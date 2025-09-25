-- Global LSP handler for deduplicating definition results from multiple LSP servers
local M = {}

-- Store pending requests and their results
local pending_requests = {}

-- Track which buffers we've already set up
local setup_buffers = {}

function M.setup()
  -- Override the gd keymap to use our custom handler
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf

      -- Only set up the keymap once per buffer
      if setup_buffers[bufnr] then
        return
      end
      setup_buffers[bufnr] = true

      vim.keymap.set("n", "gd", function()
        -- Get all active LSP clients for this buffer
        local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
        if #clients == 0 then
          vim.notify("No LSP clients attached", vim.log.levels.WARN)
          return
        end

        -- Create a unique request ID
        local request_id = tostring(vim.loop.hrtime())
        pending_requests[request_id] = {
          responses = {},
          expected = 0,
          received = 0,
        }

        -- Count how many clients support definition
        for _, client in ipairs(clients) do
          if client.supports_method("textDocument/definition") then
            pending_requests[request_id].expected = pending_requests[request_id].expected + 1
            -- Debug: log which clients will respond
            vim.notify("Client " .. client.name .. " supports definition", vim.log.levels.DEBUG)
          end
        end

        if pending_requests[request_id].expected == 0 then
          vim.notify("No LSP servers support definition", vim.log.levels.WARN)
          pending_requests[request_id] = nil
          return
        end

        -- Make position params
        local params = vim.lsp.util.make_position_params(0, 'utf-16')

        -- Send request to all supporting clients
        for _, client in ipairs(clients) do
          if client.supports_method("textDocument/definition") then
            client.request("textDocument/definition", params, function(err, result)
              if not pending_requests[request_id] then
                return -- Request was already processed
              end

              pending_requests[request_id].received = pending_requests[request_id].received + 1

              -- Debug: log response from client
              vim.notify("Received response from " .. client.name, vim.log.levels.DEBUG)

              -- Collect non-empty results
              if result and not vim.tbl_isempty(result) then
                if vim.islist(result) then
                  for _, loc in ipairs(result) do
                    table.insert(pending_requests[request_id].responses, loc)
                  end
                else
                  table.insert(pending_requests[request_id].responses, result)
                end
              end

              -- Check if all responses are received
              if pending_requests[request_id].received >= pending_requests[request_id].expected then
                -- Process all collected responses
                M.process_definitions(pending_requests[request_id].responses)
                pending_requests[request_id] = nil
              end
            end, bufnr)
          end
        end
      end, { buffer = bufnr, desc = "Go to definition (deduplicated)" })
    end,
  })
end

function M.process_definitions(results)
  if #results == 0 then
    vim.notify("No definition found", vim.log.levels.INFO)
    return
  end

  -- Debug: log total results before deduplication
  vim.notify("Processing " .. #results .. " definition results", vim.log.levels.DEBUG)

  -- Deduplicate based on URI and position
  local seen = {}
  local unique = {}

  for _, loc in ipairs(results) do
    local uri = loc.uri or loc.targetUri or ""
    local range = loc.range or loc.targetRange

    if range then
      local key = string.format("%s:%d:%d:%d:%d",
        uri,
        range.start.line,
        range.start.character,
        range["end"].line,
        range["end"].character
      )

      if not seen[key] then
        seen[key] = true
        table.insert(unique, loc)
      end
    end
  end

  -- Debug: log results after deduplication
  vim.notify("Deduplicated to " .. #unique .. " unique definitions", vim.log.levels.DEBUG)

  -- Jump to location(s)
  if #unique == 0 then
    vim.notify("No unique definitions found", vim.log.levels.INFO)
  elseif #unique == 1 then
    -- Single unique result - jump directly
    vim.lsp.util.jump_to_location(unique[1], 'utf-16')
  else
    -- Multiple unique results - use Telescope
    local ok, telescope = pcall(require, "telescope.builtin")
    if ok then
      -- Convert to telescope format
      local items = vim.lsp.util.locations_to_items(unique, 'utf-16')
      telescope.quickfix({
        qflist = items,
        prompt_title = 'LSP Definitions',
      })
    else
      -- Fallback to quickfix list
      local items = vim.lsp.util.locations_to_items(unique, 'utf-16')
      vim.fn.setqflist({}, ' ', {
        title = 'LSP Definitions',
        items = items,
      })
      vim.cmd('copen')
    end
  end
end

return M
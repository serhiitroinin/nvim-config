-- Diagnostic deduplication module
local M = {}

-- Store original vim.diagnostic.set
local original_diagnostic_set = vim.diagnostic.set
local diagnostic_cache = {}

-- Override vim.diagnostic.set to deduplicate
vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
  bufnr = bufnr or 0
  local cache_key = string.format("%d:%d", namespace, bufnr)

  -- Store diagnostics by buffer and namespace
  if not diagnostic_cache[bufnr] then
    diagnostic_cache[bufnr] = {}
  end

  diagnostic_cache[bufnr][namespace] = diagnostics

  -- Collect all diagnostics for this buffer
  local all_diagnostics = {}
  for ns, diags in pairs(diagnostic_cache[bufnr]) do
    for _, diag in ipairs(diags or {}) do
      table.insert(all_diagnostics, { namespace = ns, diagnostic = diag })
    end
  end

  -- Deduplicate diagnostics
  local seen = {}
  local unique_diagnostics = {}

  for _, entry in ipairs(all_diagnostics) do
    local diag = entry.diagnostic

    -- Create a key based on position and normalized message
    local msg = diag.message
      :gsub("%[%w+%]", "")  -- Remove source tags like [typescript]
      :gsub("^%s+", "")     -- Trim start
      :gsub("%s+$", "")     -- Trim end
      :gsub("%s+", " ")     -- Normalize spaces

    local key = string.format("%d:%d:%s",
      diag.lnum or 0,
      diag.col or 0,
      msg:sub(1, 80))

    local source = (diag.source or ""):lower()

    if not seen[key] then
      -- First occurrence
      seen[key] = { entry = entry, source = source }
      if entry.namespace == namespace then
        table.insert(unique_diagnostics, diag)
      end
    else
      -- Duplicate found
      local existing = seen[key]

      -- Prioritize TypeScript over ESLint
      local is_typescript = source:match("typescript") or source == "tsserver" or source == "ts"
      local is_eslint = source:match("eslint")
      local existing_is_typescript = existing.source:match("typescript") or existing.source == "tsserver"
      local existing_is_eslint = existing.source:match("eslint")

      -- If current is TypeScript and existing is ESLint, replace
      if is_typescript and existing_is_eslint and entry.namespace == namespace then
        table.insert(unique_diagnostics, diag)
        seen[key] = { entry = entry, source = source }
      -- If current is same namespace and not a duplicate type, include it
      elseif entry.namespace == namespace and not (is_eslint and existing_is_typescript) then
        -- Don't add if it's ESLint and we already have TypeScript
      end
    end
  end

  -- Call original with deduplicated diagnostics
  return original_diagnostic_set(namespace, bufnr, unique_diagnostics, opts)
end

-- Clean cache on buffer delete
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function(args)
    diagnostic_cache[args.buf] = nil
  end,
})

return M
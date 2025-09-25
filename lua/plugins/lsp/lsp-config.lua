return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
      ensure_installed = {
        "ts_ls",
        "eslint",
        "html",
        "cssls",
        "tailwindcss",
        "jsonls",
        "yamlls",
        "dockerls",
        "docker_compose_language_service",
        "lua_ls",
        "emmet_ls",
        "prismals",
        "graphql",
        "sqls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      -- Setup LSP deduplication for definitions
      require("lsp-dedupe").setup()

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- Set position encoding to avoid warnings
      capabilities.offsetEncoding = { "utf-16" }
      local lspconfig = require("lspconfig")
      
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        -- gd is handled by lsp-dedupe.lua for deduplication
        -- Navigation history
        vim.keymap.set("n", "gb", "<C-o>", vim.tbl_extend("force", opts, { desc = "Go back" }))
        vim.keymap.set("n", "gf", "<C-i>", vim.tbl_extend("force", opts, { desc = "Go forward" }))
        -- Keep standard Vim shortcuts as well
        vim.keymap.set("n", "<C-o>", "<C-o>", vim.tbl_extend("force", opts, { desc = "Go back" }))
        vim.keymap.set("n", "<C-i>", "<C-i>", vim.tbl_extend("force", opts, { desc = "Go forward" }))
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>df", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.goto_prev() end, opts)

        -- Enhanced diagnostic keymaps with Telescope
        vim.keymap.set("n", "<leader>dd", function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end, opts)
        vim.keymap.set("n", "<leader>dw", function() require("telescope.builtin").diagnostics() end, opts)

        -- Enhanced code actions with preview
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>qf", function()
          vim.lsp.buf.code_action({
            filter = function(a) return a.isPreferred end,
            apply = true
          })
        end, opts)

        -- Better references and implementations with Telescope
        vim.keymap.set("n", "gr", function() require("telescope.builtin").lsp_references() end, opts)
        vim.keymap.set("n", "<leader>lr", function() require("telescope.builtin").lsp_references() end, opts)
        vim.keymap.set("n", "gi", function() require("telescope.builtin").lsp_implementations() end, opts)
        vim.keymap.set("n", "gt", function() require("telescope.builtin").lsp_type_definitions() end, opts)

        -- Workspace symbols with Telescope
        vim.keymap.set("n", "<leader>ws", function() require("telescope.builtin").lsp_workspace_symbols() end, opts)
        vim.keymap.set("n", "<leader>ds", function() require("telescope.builtin").lsp_document_symbols() end, opts)

        -- Rename with preview
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)

        -- Enhanced hover in focusable window
        vim.keymap.set("n", "<leader>K", function()
          -- Use the built-in hover with focusable window
          local config = {
            focusable = true,
            border = 'rounded',
            close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "BufLeave" },
          }
          vim.lsp.buf.hover(config)
        end, opts)

        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
      end

      local function organize_imports(client, bufnr)
        local params = vim.lsp.util.make_range_params(nil, client.offset_encoding or "utf-16")
        params.context = { only = { "source.organizeImports", "source.organizeImports.ts" } }

        if not client.supports_method("textDocument/codeAction") then
          return false
        end

        local timeout_ms = 1500
        local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, timeout_ms)
        local applied = false

        local client_result = nil
        if result then
          client_result = result[client.id] or result[tostring(client.id)]
        end

        if client_result and client_result.result then
          for _, action in ipairs(client_result.result) do
            local cmd = action.command or action
            local command_name = type(cmd) == "table" and cmd.command or cmd
            if command_name ~= "NULL_LS_CODE_ACTION" then
              applied = true

              if action.edit then
                vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding or "utf-16")
              end

              if type(cmd) == "table" and cmd.command then
                client.request("workspace/executeCommand", cmd, function() end, bufnr)
              elseif type(cmd) == "string" then
                client.request("workspace/executeCommand", {
                  command = cmd,
                  arguments = { vim.api.nvim_buf_get_name(bufnr) },
                }, function() end, bufnr)
              end
            end
          end
        end

        return applied
      end

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)

          -- Prefer external formatters (null-ls/Prettier)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          -- Set up auto-commands for TypeScript/JavaScript files
          local augroup = vim.api.nvim_create_augroup("TypeScriptAutoImports", { clear = false })
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

          -- Organize imports on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              organize_imports(client, bufnr)
            end,
          })

          -- Additional keybindings for TypeScript
          local opts = { buffer = bufnr, remap = false }
          vim.keymap.set("n", "<leader>oi", function()
            organize_imports(client, bufnr)
          end, vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
          vim.keymap.set("n", "<leader>ru", function()
            vim.lsp.buf.execute_command({
              command = "_typescript.removeUnused",
              arguments = { vim.api.nvim_buf_get_name(0) },
            })
          end, vim.tbl_extend("force", opts, { desc = "Remove Unused Imports" }))
          vim.keymap.set("n", "<leader>am", function()
            vim.lsp.buf.execute_command({
              command = "_typescript.addMissingImports",
              arguments = { vim.api.nvim_buf_get_name(0) },
            })
          end, vim.tbl_extend("force", opts, { desc = "Add Missing Imports" }))
        end,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
        cmd = { "typescript-language-server", "--stdio" },
        -- Enhanced root directory detection for monorepos
        root_dir = function(fname)
          -- First try to find the nearest tsconfig.json going up from the current file
          local tsconfig_root = lspconfig.util.root_pattern("tsconfig.json")(fname)
          if tsconfig_root then
            return tsconfig_root
          end
          -- Then try package.json
          local package_root = lspconfig.util.root_pattern("package.json")(fname)
          if package_root then
            return package_root
          end
          -- Fallback to jsconfig or git root
          return lspconfig.util.root_pattern("jsconfig.json", ".git")(fname)
             or lspconfig.util.path.dirname(fname)
        end,
        single_file_support = true,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            preferences = {
              importModuleSpecifier = "shortest",
              includePackageJsonAutoImports = "auto",
              includeCompletionsForModuleExports = true,
              quotePreference = "auto",
              includeCompletionsWithInsertText = true,
              includeAutomaticOptionalChainCompletions = true,
              -- Enable path mapping resolution for aliases
              importModuleSpecifierEnding = "minimal",
              allowTextChangesInNewFiles = true,
              providePrefixAndSuffixTextForRename = true,
            },
            suggest = {
              completeFunctionCalls = true,
              includeCompletionsForImportStatements = true,
              includeAutomaticOptionalChainCompletions = true,
              autoImports = true,
              includeCompletionsForModuleExports = true,
              -- Enable suggestions for path aliases
              paths = true,
            },
            format = {
              insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
              insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
            },
            updateImportsOnFileMove = {
              enabled = "always",
            },
            -- Enable tsconfig.json path mappings
            tsserver = {
              useSyntaxServer = "auto",
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            preferences = {
              importModuleSpecifier = "shortest",
              includePackageJsonAutoImports = "auto",
              includeCompletionsForModuleExports = true,
              quotePreference = "auto",
              includeCompletionsWithInsertText = true,
              includeAutomaticOptionalChainCompletions = true,
            },
            suggest = {
              completeFunctionCalls = true,
              includeCompletionsForImportStatements = true,
              includeAutomaticOptionalChainCompletions = true,
              autoImports = true,
              includeCompletionsForModuleExports = true,
            },
            format = {
              insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
              insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
            },
            updateImportsOnFileMove = {
              enabled = "always",
            },
          },
          completions = {
            completeFunctionCalls = true,
          },
        },
        init_options = {
          hostInfo = "neovim",
          preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            importModuleSpecifierPreference = "shortest",
            allowIncompleteCompletions = true,
            includeCompletionsForModuleExports = true,
            -- Support for monorepo project references
            disableAutomaticTypeAcquisition = false,
            includeCompletionsWithClassMemberSnippets = true,
            includeCompletionsWithObjectLiteralMethodSnippets = true,
          },
          -- Enable plugins for better monorepo support
          plugins = {
            {
              name = "typescript-language-service",
              location = "auto",
            },
          },
        },
      })

      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)

          -- Disable ESLint diagnostics that duplicate TypeScript's
          -- ESLint will still run for fixing but won't show duplicate diagnostics
          client.server_capabilities.documentFormattingProvider = true

          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        settings = {
          -- Only show ESLint-specific rules, not TypeScript errors
          rulesCustomizations = {
            { rule = "@typescript-eslint/no-unused-vars", severity = "off" },
          },
        },
      })

      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              },
            },
          },
        },
      })

      lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "html", "htmldjango" },
      })

      lspconfig.cssls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      lspconfig.yamlls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          yaml = {
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })

      lspconfig.dockerls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig.docker_compose_language_service.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
      })

      lspconfig.prismals.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig.graphql.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
      })

      lspconfig.sqls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end,
  },
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
}

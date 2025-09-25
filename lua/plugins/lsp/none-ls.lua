return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    
    -- Fix for _request_name_to_capability nil error in Neovim 0.11.x
    -- This field was removed in newer Neovim versions but none-ls still references it
    if not vim.lsp._request_name_to_capability then
      vim.lsp._request_name_to_capability = {
        ["textDocument/hover"] = { "hoverProvider" },
        ["textDocument/formatting"] = { "documentFormattingProvider" },
        ["textDocument/rangeFormatting"] = { "documentRangeFormattingProvider" },
        ["textDocument/codeAction"] = { "codeActionProvider" },
        ["textDocument/completion"] = { "completionProvider" },
        ["textDocument/definition"] = { "definitionProvider" },
        ["textDocument/references"] = { "referencesProvider" },
        ["textDocument/rename"] = { "renameProvider" },
        ["textDocument/signatureHelp"] = { "signatureHelpProvider" },
        ["textDocument/typeDefinition"] = { "typeDefinitionProvider" },
        ["textDocument/implementation"] = { "implementationProvider" },
        ["textDocument/documentSymbol"] = { "documentSymbolProvider" },
        ["workspace/symbol"] = { "workspaceSymbolProvider" },
      }
    end

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettierd.with({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "css",
            "scss",
            "less",
            "html",
            "json",
            "jsonc",
            "yaml",
            "markdown",
            "markdown.mdx",
            "graphql",
            "handlebars",
          },
        }),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.sql_formatter,
        null_ls.builtins.code_actions.gitsigns,
      },
      on_attach = function(client, bufnr)
        -- Ensure _request_name_to_capability exists
        if not client._request_name_to_capability then
          client._request_name_to_capability = {}
        end
        
        if client.supports_method and client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              if vim.b.disable_autoformat or vim.g.disable_autoformat then
                return
              end

              vim.lsp.buf.format({
                async = false,
                bufnr = bufnr,
                filter = function(format_client)
                  return format_client.name == "null-ls"
                end,
              })
            end,
          })
        end
      end,
    })

    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Code: format file" })
  end,
}

return {
  -- Better substitute with preview
  {
    "gbprod/substitute.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local substitute = require("substitute")

      substitute.setup({
        on_substitute = nil,
        yank_substituted_text = false,
        preserve_cursor_position = false,
        modifiers = nil,
        highlight_substituted_text = {
          enabled = true,
          timer = 500,
        },
        range = {
          prefix = "s",
          prompt_current_text = false,
          confirm = false,
          complete_word = false,
          subject = nil,
          range = nil,
          suffix = "",
          auto_apply = false,
          cursor_position = "end",
        },
        exchange = {
          motion = false,
          use_esc_to_cancel = true,
          preserve_cursor_position = false,
        },
      })

      -- Keymaps (use <leader>rs to avoid clobbering LSP defaults)
      vim.keymap.set("n", "<leader>rs", substitute.operator, { desc = "Substitute with motion" })
      vim.keymap.set("n", "<leader>rS", substitute.line, { desc = "Substitute line" })
      vim.keymap.set("n", "<leader>re", substitute.eol, { desc = "Substitute to end of line" })
      vim.keymap.set("x", "<leader>rs", substitute.visual, { desc = "Substitute selection" })

      -- Range substitute (using s prefix for substitute)
      vim.keymap.set("n", "<leader>sw", function()
        return substitute.operator() .. "iw"
      end, { expr = true, desc = "Substitute word" })
      vim.keymap.set("n", "<leader>sW", function()
        require("substitute.range").word()
      end, { desc = "Substitute word in range" })

      vim.keymap.set("x", "<leader>sv", function()
        require("substitute.range").visual()
      end, { desc = "Substitute in visual range" })

      -- Exchange
      vim.keymap.set("n", "gx", require("substitute.exchange").operator, { desc = "Exchange operator" })
      vim.keymap.set("n", "gxx", require("substitute.exchange").line, { desc = "Exchange line" })
      vim.keymap.set("x", "gx", require("substitute.exchange").visual, { desc = "Exchange visual" })
      vim.keymap.set("n", "gxc", require("substitute.exchange").cancel, { desc = "Cancel exchange" })
    end,
  },
}

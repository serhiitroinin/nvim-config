return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize" },
    },
    config = function(_, opts)
      local persistence = require("persistence")
      persistence.setup(opts)

      vim.keymap.set("n", "<leader>ps", persistence.save, { desc = "Session: save" })
      vim.keymap.set("n", "<leader>pr", function()
        persistence.load()
      end, { desc = "Session: restore" })
      vim.keymap.set("n", "<leader>pl", function()
        persistence.load({ last = true })
      end, { desc = "Session: restore last" })
      vim.keymap.set("n", "<leader>px", persistence.stop, { desc = "Session: stop tracking" })
    end,
  },
}

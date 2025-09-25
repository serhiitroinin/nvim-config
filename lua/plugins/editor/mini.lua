return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      -- Setup useful mini.nvim modules
      -- Each module needs to be set up separately

      -- Better Around/Inside textobjects
      require('mini.ai').setup({
        n_lines = 500,
      })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup()

      -- Simple and easy statusline
      -- Disabled if you're using lualine
      -- require('mini.statusline').setup()

      -- Useful pairs of mappings
      require('mini.pairs').setup()

      -- Fast and feature-rich surround actions
      -- require('mini.comment').setup() -- Disabled if using Comment.nvim

      -- Move text in any direction
      require('mini.move').setup({
        mappings = {
          -- Move visual selection in Visual mode
          left = '<M-h>',
          right = '<M-l>',
          down = '<M-j>',
          up = '<M-k>',
          -- Move current line in Normal mode
          line_left = '<M-h>',
          line_right = '<M-l>',
          line_down = '<M-j>',
          line_up = '<M-k>',
        },
      })
    end,
  },
}

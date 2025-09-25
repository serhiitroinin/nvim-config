return {
  "folke/zen-mode.nvim",
  cmd = { "ZenMode" },
  config = function()
    require("zen-mode").setup({
      window = {
        backdrop = 1,
        width = 100,
        height = 0.85,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "5",
          list = false,
          -- fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = false },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
        kitty = {
          enabled = false,
          font = "+4",
        },
      },
      on_open = function(win)
        vim.wo.wrap = true
        vim.wo.linebreak = true
        vim.opt.spelllang = "en_us"
        vim.opt.spell = true
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.signcolumn = "no"
        local ok, snacks = pcall(require, "snacks")
        if ok and snacks.explorer then
          snacks.explorer.close_all()
        end
      end,
      on_close = function()
        vim.wo.wrap = false
        vim.wo.linebreak = false
        vim.opt.spell = false
        -- Ensure tmux status is restored
        vim.fn.system("tmux set -g status on 2>/dev/null")
      end,
    })
  end,
  dependencies = {
    "folke/twilight.nvim",
    opts = {
      dimming = {
        alpha = 0.25,
        color = { "Normal", "#ffffff" },
        term_bg = "#000000",
        inactive = false,
      },
      context = 10,
      treesitter = true,
      expand = {
        "function",
        "method",
        "table",
        "if_statement",
      },
    },
  },
}

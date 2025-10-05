return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      -- Detect system appearance and set background BEFORE loading theme
      local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
      local result = handle:read("*a")
      handle:close()

      vim.o.background = result:match("Dark") and "dark" or "light"

      -- Everforest theme configuration
      require("everforest").setup({
        background = "medium",
        transparent_background_level = 0,
        italics = true,
        dim_inactive_windows = false,
        sign_column_background = "none",
      })

      -- Load the colorscheme
      vim.cmd.colorscheme("everforest")
    end,
  },

  -- Auto dark/light mode switching
  {
    "f-person/auto-dark-mode.nvim",
    enabled = false,
  },

  -- Custom auto-switching that actually works
  {
    dir = vim.fn.stdpath("config"),
    name = "theme-auto-switch",
    lazy = false,
    priority = 999,
    config = function()
      local function get_system_mode()
        local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
        local result = handle:read("*a")
        handle:close()
        return result:match("Dark") and "dark" or "light"
      end

      local function sync_tmux()
        if os.getenv("TMUX") then
          vim.fn.jobstart({ os.getenv("HOME") .. "/.tmux/theme-switcher.sh" }, { detach = true })
        end
      end

      local function apply_theme(mode)
        if vim.o.background ~= mode then
          vim.o.background = mode
          vim.cmd("colorscheme everforest")

          -- Refresh lualine
          pcall(function()
            require("lualine").refresh()
          end)

          sync_tmux()
        end
      end

      -- Check every 2 seconds
      vim.fn.timer_start(2000, function()
        apply_theme(get_system_mode())
      end, { ["repeat"] = -1 })

      -- Check on focus
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          apply_theme(get_system_mode())
        end,
      })
    end,
  },
}

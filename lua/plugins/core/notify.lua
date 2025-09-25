return {
  -- Notification system using nvim-notify (stable and widely compatible)
  {
    "rcarriga/nvim-notify",
    lazy = false,
    priority = 1000,
    config = function()
      local notify = require("notify")

      -- Configure nvim-notify
      notify.setup({
        -- Animation style
        stages = "fade_in_slide_out",
        -- Timeout for notifications
        timeout = 3000,
        -- Maximum width of notification windows
        max_width = 80,
        -- Maximum height of notification windows
        max_height = 20,
        -- Notification opacity
        background_colour = "#000000",
        -- Icons for different log levels
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        },
        -- Render style
        render = "compact",
        -- Minimum width
        minimum_width = 50,
        -- Position
        top_down = true,
      })

      -- Set as default vim.notify handler
      -- This automatically handles all API variations correctly
      vim.notify = notify

      -- Create user commands for notification history
      vim.api.nvim_create_user_command("NotifyHistory", function()
        require("telescope").extensions.notify.notify()
      end, { desc = "Show notification history" })

      vim.api.nvim_create_user_command("NotifyClear", function()
        notify.dismiss({ pending = true, silent = true })
      end, { desc = "Clear all notifications" })

      -- Optional keymaps
      vim.keymap.set("n", "<leader>nh", ":NotifyHistory<CR>", { desc = "Notification history", silent = true })
      vim.keymap.set("n", "<leader>nc", ":NotifyClear<CR>", { desc = "Clear notifications", silent = true })
    end,
  },

  -- Telescope integration for nvim-notify
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "rcarriga/nvim-notify",
    },
    config = function()
      -- Load telescope notify extension if available
      pcall(function()
        require("telescope").load_extension("notify")
      end)
    end,
  },
}
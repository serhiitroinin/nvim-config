return {
  {
    "folke/snacks.nvim",
    priority = 100,
    opts = {
      explorer = {
        replace_netrw = true,
        mappings = {
          v = "open_vsplit",
          s = "open_split",
          t = "open_tab",
          ["."] = "toggle_hidden",
        },
        sources = {
          { "files", hidden = false },
          { "git_status" },
        },
        view = {
          width = 0.28,
        },
      },
      dashboard = {
        enabled = true,
        preset = {
          pick = "Telescope",
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = "<leader>ff" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = "<leader>fg" },
            { icon = " ", key = "r", desc = "Recent Files", action = "<leader>fo" },
            { icon = " ", key = "c", desc = "Config", action = ":e ~/.config/nvim/init.lua" },
            { icon = " ", key = "s", desc = "Restore Session", action = ":lua require('persistence').load()" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
          ]],
        },
        sections = {
          -- Left pane
          { section = "header", padding = 1 },
          {
            section = "terminal",
            cmd = "date '+%A, %B %d %Y - %H:%M' && uname -srm",
            height = 2,
            padding = 1,
            indent = 2,
          },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },

          -- Right pane (pane 2)
          {
            pane = 2,
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            indent = 2,
            padding = { 1, 1 },
            limit = 8,
          },
          {
            pane = 2,
            icon = " ",
            title = "Projects",
            section = "projects",
            indent = 2,
            padding = { 1, 1 },
            limit = 6,
          },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return vim.fn.isdirectory(".git") == 1
            end,
            cmd = "git status -sb 2>/dev/null | head -8",
            height = 8,
            padding = { 1, 1 },
            ttl = 5 * 60,
            indent = 2,
          },
          {
            pane = 2,
            icon = " ",
            title = "Todo Comments",
            section = "terminal",
            enabled = function()
              -- Only show if we have rg installed
              return vim.fn.executable("rg") == 1
            end,
            cmd = "rg --color=never --no-heading 'TODO|FIXME' 2>/dev/null | head -5 | cut -d: -f1,3 | sed 's/:/ - /' | cut -c1-60",
            height = 5,
            padding = { 1, 1 },
            ttl = 5 * 60,
            indent = 2,
          },
        },
        -- Multi-pane configuration
        panes = {
          { size = 0.5 },  -- Left pane takes 50% width
          { size = 0.5 },  -- Right pane takes 50% width
        },
      },
      notifier = {
        enabled = false,  -- Disabled - using nvim-notify instead for better compatibility
      },
      terminal = {
        win = {
          style = "minimal",
        },
      },
    },
    config = function(_, opts)
      local snacks = require("snacks")
      snacks.setup(opts)

      local explorer = snacks.explorer
      local picker = snacks.picker
      local terminal = snacks.terminal
      local dashboard = snacks.dashboard

      -- Notification handling is done by nvim-notify (see plugins/core/notify.lua)
      -- This provides better compatibility with all plugins

      local function git_root()
        local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        if vim.v.shell_error == 0 and root and root ~= "" then
          return root
        end
        return vim.loop.cwd()
      end

      -- Setup dashboard only when no files are opened
      if dashboard then
        -- Create a command to manually open the dashboard
        vim.api.nvim_create_user_command("Dashboard", function()
          dashboard.open()
        end, { desc = "Open dashboard" })

        -- Auto-open dashboard only if no files are specified
        if vim.fn.argc() == 0 then
          vim.api.nvim_create_autocmd("VimEnter", {
            once = true,
            callback = function()
              -- Small delay to ensure everything is loaded
              vim.defer_fn(function()
                if vim.fn.line2byte(vim.fn.line('$')) == -1 then
                  dashboard.open()
                end
              end, 10)
            end,
          })
        end
      end

      -- Dashboard keymap
      vim.keymap.set("n", "<leader>;", function()
        dashboard.open()
      end, { desc = "Dashboard" })

      vim.keymap.set("n", "<leader>fe", function()
        explorer.open({ position = "left", width = 40 })
      end, { desc = "Explorer (Snacks)" })

      vim.keymap.set("n", "<leader>fE", function()
        explorer.open({ dir = git_root(), position = "left", width = 40 })
      end, { desc = "Explorer (project root)" })

      vim.keymap.set("n", "<leader>f.", function()
        explorer.open({ dir = vim.fn.expand("%:p:h"), focus = false, position = "float" })
      end, { desc = "Explorer (float in file dir)" })

      vim.keymap.set("n", "<leader>fx", function()
        explorer.close_all()
      end, { desc = "Close explorers" })

      if picker then
        vim.keymap.set("n", "<leader>xx", function()
          picker.diagnostics({})
        end, { desc = "Diagnostics (workspace)" })

        vim.keymap.set("n", "<leader>xX", function()
          picker.diagnostics({ bufnr = 0 })
        end, { desc = "Diagnostics (buffer)" })

        vim.keymap.set("n", "<leader>cs", function()
          picker.lsp_symbols({})
        end, { desc = "Symbols" })
      end

      if terminal then
        vim.keymap.set("n", "<leader>Tf", function()
          terminal.open({ layout = "float" })
        end, { desc = "Terminal (float)" })

        vim.keymap.set("n", "<leader>Th", function()
          terminal.open({ layout = "horizontal" })
        end, { desc = "Terminal (horizontal)" })

        vim.keymap.set("n", "<leader>Tv", function()
          terminal.open({ layout = "vertical" })
        end, { desc = "Terminal (vertical)" })

        vim.keymap.set("n", "<leader>Tn", function()
          terminal.run({ cmd = { "node" }, layout = "float" })
        end, { desc = "Node REPL" })

        vim.keymap.set("n", "<leader>Tp", function()
          terminal.run({ cmd = { "python3" }, layout = "float" })
        end, { desc = "Python REPL" })
      end
    end,
  },
}

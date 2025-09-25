-- Telescope Icon Picker
-- Browse and copy Nerd Font icons

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local icons = require("icons")

    -- Flatten all icons into a single list for searching
    local function get_all_icons()
      local icon_list = {}

      for category, category_icons in pairs(icons) do
        if type(category_icons) == "table" and category ~= "get" and category ~= "neotree" then
          for name, icon in pairs(category_icons) do
            if type(icon) == "string" then
              table.insert(icon_list, {
                icon = icon,
                name = name,
                category = category,
                display = string.format("%s  %s.%s", icon, category, name)
              })
            end
          end
        end
      end

      return icon_list
    end

    -- Create the icon picker
    local function icon_picker(opts)
      opts = opts or {}

      pickers.new(opts, {
        prompt_title = "Nerd Font Icons",
        finder = finders.new_table({
          results = get_all_icons(),
          entry_maker = function(entry)
            return {
              value = entry.icon,
              display = entry.display,
              ordinal = entry.category .. " " .. entry.name .. " " .. entry.icon,
            }
          end,
        }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection then
              -- Copy icon to clipboard
              vim.fn.setreg("+", selection.value)
              vim.fn.setreg('"', selection.value)
              vim.notify("Copied icon: " .. selection.value, vim.log.levels.INFO)
            end
          end)

          -- Insert icon at cursor with <C-i>
          map("i", "<C-i>", function()
            local selection = action_state.get_selected_entry()
            if selection then
              actions.close(prompt_bufnr)
              vim.api.nvim_put({selection.value}, "c", true, true)
            end
          end)

          return true
        end,
        previewer = false,
      }):find()
    end

    -- Create command
    vim.api.nvim_create_user_command("IconPicker", function()
      icon_picker()
    end, { desc = "Open icon picker" })

    -- Add keymap
    vim.keymap.set("n", "<leader>fi", function()
      icon_picker()
    end, { desc = "Find icons" })

    -- Quick icon reference command
    vim.api.nvim_create_user_command("IconRef", function()
      local categories = {}
      for cat, _ in pairs(icons) do
        if type(icons[cat]) == "table" and cat ~= "get" then
          table.insert(categories, cat)
        end
      end
      table.sort(categories)

      vim.ui.select(categories, {
        prompt = "Select icon category:",
      }, function(choice)
        if choice then
          local category_icons = {}
          for name, icon in pairs(icons[choice]) do
            if type(icon) == "string" then
              table.insert(category_icons, string.format("%s  %s", icon, name))
            end
          end
          table.sort(category_icons)

          -- Show in a floating window
          local buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, category_icons)
          vim.api.nvim_buf_set_option(buf, "modifiable", false)

          local width = 40
          local height = math.min(#category_icons, 20)

          local win = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            width = width,
            height = height,
            col = (vim.o.columns - width) / 2,
            row = (vim.o.lines - height) / 2,
            border = "rounded",
            title = " " .. choice .. " icons ",
            title_pos = "center",
          })

          -- Close with q or Esc
          vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf })
          vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf })

          -- Copy icon on Enter
          vim.keymap.set("n", "<cr>", function()
            local line = vim.api.nvim_get_current_line()
            local icon = line:match("^(.) ")
            if icon then
              vim.fn.setreg("+", icon)
              vim.fn.setreg('"', icon)
              vim.notify("Copied: " .. icon, vim.log.levels.INFO)
            end
          end, { buffer = buf })
        end
      end)
    end, { desc = "Icon reference by category" })
  end,
}
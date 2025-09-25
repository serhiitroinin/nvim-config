-- Theme utilities for Nord
local M = {}

-- Toggle between light and dark themes
function M.toggle_theme()
	local current_bg = vim.o.background
	local new_mode = (current_bg == "dark") and "light" or "dark"

	vim.o.background = new_mode
	vim.cmd([[ colorscheme nord ]])

	-- Force lualine refresh
	local ok_lualine, lualine = pcall(require, "lualine")
	if ok_lualine then
		lualine.refresh()
	end

	print("Switched to " .. new_mode .. " mode")
end

-- Check current theme
function M.check_theme()
	print("Current background: " .. vim.o.background)
	print("Current colorscheme: " .. vim.g.colors_name)
end

-- Create user commands
vim.api.nvim_create_user_command("ToggleTheme", M.toggle_theme, {})
vim.api.nvim_create_user_command("CheckTheme", M.check_theme, {})

return M

return {
	-- Nord colorscheme
	{
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- Nord theme configuration
			vim.g.nord_contrast = true
			vim.g.nord_borders = false
			vim.g.nord_disable_background = false
			vim.g.nord_italic = false
			vim.g.nord_uniform_diff_background = true
			vim.g.nord_bold = false

			-- Load the colorscheme
			require("nord").set()
		end,
	},

	-- Auto dark/light mode switching
	{
		"f-person/auto-dark-mode.nvim",
		lazy = false,
		priority = 999,
		config = function()
			local auto_dark_mode = require("auto-dark-mode")

			auto_dark_mode.setup({
				update_interval = 60000,
				set_dark_mode = function()
					vim.o.background = "dark"
					vim.cmd("colorscheme nord")
					
					-- Force lualine refresh
					local ok_lualine, lualine = pcall(require, "lualine")
					if ok_lualine then
						lualine.refresh()
					end
				end,
				set_light_mode = function()
					-- Nord doesn't have a built-in light variant, but we can use a light theme that complements it
					vim.o.background = "light"
					vim.cmd("colorscheme nord")
					
					-- Force lualine refresh
					local ok_lualine, lualine = pcall(require, "lualine")
					if ok_lualine then
						lualine.refresh()
					end
				end,
			})

			-- Initialize with current system appearance
			auto_dark_mode.init()
		end,
	},
}

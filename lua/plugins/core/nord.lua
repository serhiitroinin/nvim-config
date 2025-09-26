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

			-- Fix visibility of ignored/hidden files in file explorers
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "nord",
				callback = function()
					-- Make ignored/hidden files more visible (use a brighter gray)
					vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { fg = "#616E88", italic = true })
					vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { fg = "#88C0D0", underline = true })
					vim.api.nvim_set_hl(0, "NeoTreeDimText", { fg = "#616E88" })
					vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = "#616E88", italic = true })
					vim.api.nvim_set_hl(0, "NeoTreeHiddenByName", { fg = "#616E88", italic = true })
					vim.api.nvim_set_hl(0, "Comment", { fg = "#616E88", italic = true })

					-- Snacks explorer (oil.nvim style)
					vim.api.nvim_set_hl(0, "OilDimText", { fg = "#616E88" })
					vim.api.nvim_set_hl(0, "SnacksExplorerDim", { fg = "#616E88" })
					vim.api.nvim_set_hl(0, "SnacksExplorerHidden", { fg = "#616E88", italic = true })
					vim.api.nvim_set_hl(0, "SnacksExplorerSpecial", { fg = "#88C0D0" })

					-- General directory and special file colors
					vim.api.nvim_set_hl(0, "Directory", { fg = "#88C0D0" })
					vim.api.nvim_set_hl(0, "NonText", { fg = "#4C566A" })
					vim.api.nvim_set_hl(0, "Whitespace", { fg = "#3B4252" })
					vim.api.nvim_set_hl(0, "SpecialKey", { fg = "#4C566A" })
				end
			})

			-- Apply the highlights immediately
			vim.cmd("doautocmd ColorScheme nord")
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

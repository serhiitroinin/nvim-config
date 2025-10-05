return {
	-- Nord colorscheme
	{
		"shaunsingh/nord.nvim",
		enabled = false,
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
					-- Determine colors based on background (light/dark mode)
					local is_light = vim.o.background == "light"

					local dim_color, very_dim_color, hidden_color, dir_color

					if is_light then
						-- Light theme colors (darker for visibility on light background)
						hidden_color = "#6C7A89"   -- Dark gray for hidden files on light bg
						dim_color = "#7B8799"      -- Slightly darker
						very_dim_color = "#8A95A7" -- For comments
						dir_color = "#5E81AC"      -- Darker blue for directories
					else
						-- Dark theme colors (brighter for visibility on dark background)
						hidden_color = "#9099AB"   -- Bright gray for hidden files on dark bg
						dim_color = "#8A95A7"      -- Clearly visible but still "dimmed"
						very_dim_color = "#7B88A1" -- For comments and less important items
						dir_color = "#88C0D0"      -- Nord cyan for directories
					end

					-- Make ignored/hidden files more visible
					vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { fg = hidden_color, italic = true })
					vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { fg = dir_color, underline = true })
					vim.api.nvim_set_hl(0, "NeoTreeDimText", { fg = hidden_color })
					vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = hidden_color, italic = true })
					vim.api.nvim_set_hl(0, "NeoTreeHiddenByName", { fg = hidden_color, italic = true })
					vim.api.nvim_set_hl(0, "Comment", { fg = very_dim_color, italic = true })

					-- Snacks explorer - comprehensive coverage
					vim.api.nvim_set_hl(0, "OilDimText", { fg = hidden_color })
					vim.api.nvim_set_hl(0, "SnacksExplorerDim", { fg = hidden_color })
					vim.api.nvim_set_hl(0, "SnacksExplorerHidden", { fg = hidden_color, italic = true })
					vim.api.nvim_set_hl(0, "SnacksExplorerSpecial", { fg = dir_color })
					vim.api.nvim_set_hl(0, "SnacksExplorerIgnored", { fg = hidden_color, italic = true })
					vim.api.nvim_set_hl(0, "SnacksExplorerDotfile", { fg = hidden_color, italic = true })

					-- Git-specific items
					vim.api.nvim_set_hl(0, "SnacksExplorerGitIgnore", { fg = hidden_color, italic = true })
					vim.api.nvim_set_hl(0, "SnacksExplorerGitIgnored", { fg = hidden_color, italic = true })

					-- Fallback for any "ignored" or "dim" patterns
					vim.api.nvim_set_hl(0, "Ignored", { fg = hidden_color, italic = true })
					vim.api.nvim_set_hl(0, "GitIgnored", { fg = hidden_color, italic = true })

					-- General directory and special file colors
					vim.api.nvim_set_hl(0, "Directory", { fg = dir_color })
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
		enabled = false,
		lazy = false,
		priority = 999,
		config = function()
			local auto_dark_mode = require("auto-dark-mode")

			auto_dark_mode.setup({
				update_interval = 60000,
				set_dark_mode = function()
					vim.o.background = "dark"
					vim.cmd("colorscheme nord")

					-- Trigger ColorScheme autocmd to apply our custom highlights
					vim.cmd("doautocmd ColorScheme nord")

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

					-- Trigger ColorScheme autocmd to apply our custom highlights for light mode
					vim.cmd("doautocmd ColorScheme nord")

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

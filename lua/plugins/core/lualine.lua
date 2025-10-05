return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")
		local icons = require("icons")

		lualine.setup({
    options = {
      icons_enabled = true,
      theme = "everforest", -- Use everforest theme
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{ "branch", icon = icons.git.branch },
					{
						"diff",
						symbols = {
							added = icons.git.added .. " ",
							modified = icons.git.modified .. " ",
							removed = icons.git.removed .. " ",
						},
					},
					{
						"diagnostics",
						symbols = {
							error = icons.diagnostics.error .. " ",
							warn = icons.diagnostics.warn .. " ",
							info = icons.diagnostics.info .. " ",
							hint = icons.diagnostics.hint .. " ",
						},
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1,
						symbols = {
							modified = " " .. icons.neotree.modified,
							readonly = " " .. icons.bufferline.readonly,
							unnamed = " [No Name]",
							newfile = " [New]",
						},
					}
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}

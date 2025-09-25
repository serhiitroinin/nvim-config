return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			local wk = require("which-key")
			wk.setup({
				plugins = {
					marks = true,
					registers = true,
					spelling = {
						enabled = false,
					},
					presets = {
						operators = true,
						motions = true,
						text_objects = true,
						windows = true,
						nav = true,
						z = true,
						g = true,
					},
				},
				win = {
					border = "rounded",
				},
				layout = {
					height = { min = 4, max = 25 },
					width = { min = 20, max = 50 },
					spacing = 3,
					align = "center",
				},
			})

			-- Register keymap groups - these will be supplemented by after/plugin/keymaps.lua
			wk.add({
				-- Primary single-letter groups (lowercase)
				{ "<leader>a", group = "AI/Add imports" },
				{ "<leader>c", group = "Code Actions" },
				{ "<leader>d", group = "Diagnostics" },
				{ "<leader>fe", desc = "Explorer (Snacks)" },
				{ "<leader>f.", desc = "Explorer (Snacks float)" },
				{ "<leader>f", group = "Find (Telescope)" },
				{ "<leader>g", group = "Git" },
				{ "<leader>h", group = "Harpoon/Help" },
				{ "<leader>i", group = "Import/Insert" },
				{ "<leader>j", group = "Jump/Navigate" },
				{ "<leader>l", group = "LSP" },
				{ "<leader>n", group = "Notifications" },
				{ "<leader>o", group = "Organize/Outline" },
				{ "<leader>p", group = "Paste/Project" },
				{ "<leader>r", group = "Rename/Remove" },
				{ "<leader>s", group = "Stage/Session" },
				{ "<leader>t", group = "Testing" },
				{ "<leader>tO", desc = "Test output panel" },
				{ "<leader>ti", desc = "Test summary" },
				{ "<leader>tw", desc = "Watch test file" },
				{ "<leader>tW", desc = "Watch nearest test" },
				{ "<leader>u", group = "UI/Utils" },
				{ "<leader>v", group = "View/Vim" },
				{ "<leader>w", desc = "Write/Save" },
				{ "<leader>x", desc = "Diagnostics (Snacks)" },
				{ "<leader>y", desc = "Yank to clipboard" },
				{ "<leader>z", group = "Fold/Zen" },

				-- Capital letter groups (secondary/special operations)
				{ "<leader>C", group = "Comments" },
				{ "<leader>fE", desc = "Explorer (Snacks root)" },
				{ "<leader>fx", desc = "Close explorers" },
				{ "<leader>fy", desc = "Yazi file manager" },
				{ "<leader>fY", desc = "Yazi file manager (root)" },
				{ "<leader>H", group = "Help" },
				{ "<leader>K", desc = "Hover (persistent)" },
				{ "<leader>S", desc = "Simple Replace" },
				{ "<leader>T", group = "Terminal" },
				{ "<leader>W", group = "Workspace" },
				{ "<leader>Q", desc = "Quit all" },
				{ "<leader>Y", desc = "Yank line to clipboard" },

				-- Sub-groups that will be populated by specific plugins
				{ "<leader>gt", group = "Git toggle" },
				{ "<leader>gs", group = "Git stage" },
				{ "<leader>gd", group = "Git diff" },
				{ "<leader>gtb", desc = "Toggle line blame" },
				{ "<leader>gtd", desc = "Toggle deleted" },
				
				-- Jump sub-groups
				{ "<leader>jt", desc = "Jump to next failed test" },
				{ "<leader>jT", desc = "Jump to previous failed test" },
				
				-- Terminal sub-groups
				{ "<leader>Tf", desc = "Terminal floating" },
				{ "<leader>Th", desc = "Terminal horizontal" },
				{ "<leader>Tv", desc = "Terminal vertical" },
				{ "<leader>Tn", desc = "Terminal Node" },
				{ "<leader>Tp", desc = "Terminal Python" },

				-- Go-to navigation (g prefix)
				{ "g", group = "Go to", mode = "n" },
				{ "gd", desc = "Go to definition (deduplicated)" },
				{ "gb", desc = "Go back (navigation)" },
				{ "gf", desc = "Go forward (navigation)" },
				{ "gD", desc = "Go to declaration" },
				{ "gi", desc = "Go to implementation" },
				{ "gr", desc = "Go to references" },
				{ "gt", desc = "Go to type definition" },
				{ "gB", desc = "Block comment motion" },

				-- Comments
				{ "gc", group = "Comment", mode = { "n", "v" } },
				{ "gcc", desc = "Toggle line comment" },
				{ "gbc", desc = "Toggle block comment" },
				{ "gcO", desc = "Comment above" },
				{ "gco", desc = "Comment below" },
				{ "gcA", desc = "Comment end of line" },

				-- Text objects/operations
				{ "gs", group = "Surround" },

				-- Special keys
				{ "<leader><space>", desc = "Clear highlight" },
				{ "<leader>?", desc = "Show keymaps reference" },
				{ "<leader>q", desc = "Quit" },

				-- Control key navigation
				{ "<C-h>", desc = "Navigate left window" },
				{ "<C-j>", desc = "Navigate down window" },
				{ "<C-k>", desc = "Navigate up window" },
				{ "<C-l>", desc = "Navigate right window" },
				{ "<C-o>", desc = "Jump back" },
				{ "<C-i>", desc = "Jump forward" },
				{ "<C-d>", desc = "Scroll down (centered)" },
				{ "<C-u>", desc = "Scroll up (centered)" },

				-- Hover
				{ "K", desc = "Hover documentation" },

				-- Navigation helpers
				{ "[", group = "Previous", mode = "n" },
				{ "]", group = "Next", mode = "n" },
				{ "[h", desc = "Previous hunk" },
				{ "]h", desc = "Next hunk" },
				{ "[d", desc = "Previous diagnostic" },
				{ "]d", desc = "Next diagnostic" },

				-- Flash navigation (if installed)
				{ "s", desc = "Flash jump", mode = { "n", "x", "o" } },
				{ "S", desc = "Flash treesitter", mode = { "n", "x", "o" } },

				-- Visual mode specific
				{ "<leader>", group = "Leader", mode = "v" },
				{ "J", desc = "Move line down", mode = "v" },
				{ "K", desc = "Move line up", mode = "v" },

				-- F-key mappings
				{ "<F5>", desc = "Debug: Start/Continue" },
				{ "<F7>", desc = "Debug UI toggle" },
				{ "<F10>", desc = "Debug: Step Over" },
				{ "<F11>", desc = "Debug: Step Into" },
				{ "<F12>", desc = "Debug: Step Out" },
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("Comment").setup({
				-- Add a space between comment and the line
				padding = true,
				-- Whether the cursor should stay at its position
				sticky = true,
				-- Lines to be ignored while (un)comment
				ignore = nil,
				-- LHS of toggle mappings in NORMAL mode
				toggler = {
					-- Line-comment toggle keymap
					line = "gcc",
					-- Block-comment toggle keymap
					block = "gbc",
				},
				-- LHS of operator-pending mappings in NORMAL and VISUAL mode
				opleader = {
					-- Line-comment keymap
					line = "gc",
					-- Block-comment keymap
					block = "gB",  -- Changed from gb to gB to avoid conflict with "go back"
				},
				-- LHS of extra mappings
				extra = {
					-- Add comment on the line above
					above = "gcO",
					-- Add comment on the line below
					below = "gco",
					-- Add comment at the end of line
					eol = "gcA",
				},
				-- Enable keybindings
				mappings = {
					-- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
					basic = true,
					-- Extra mapping; `gco`, `gcO`, `gcA`
					extra = true,
				},
				-- Function to call before (un)comment
				pre_hook = function(ctx)
					-- For JSX/TSX comments
					local U = require("Comment.utils")

					-- Determine whether to use linewise or blockwise commentstring
					local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

					-- Determine the location where to calculate commentstring from
					local location = nil
					if ctx.ctype == U.ctype.blockwise then
						location = require("ts_context_commentstring.utils").get_cursor_location()
					elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
						location = require("ts_context_commentstring.utils").get_visual_start_location()
					end

					return require("ts_context_commentstring.internal").calculate_commentstring({
						key = type,
						location = location,
					})
				end,
				-- Function to call after (un)comment
				post_hook = nil,
			})

			-- Additional keymaps for block comments
			vim.keymap.set("n", "<leader>cb", "gbc", { desc = "Toggle block comment", remap = true })
			vim.keymap.set("v", "<leader>cb", "gB", { desc = "Toggle block comment", remap = true })

			-- Comment text objects
			vim.keymap.set("n", "gcip", "gcgc", { desc = "Comment inner paragraph", remap = true })
			vim.keymap.set("n", "gcaf", "gcgcaf", { desc = "Comment a function", remap = true })
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"snacks_dashboard",
					"lazy",
					"mason",
				},
			},
		},
	},
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				names = false,
				tailwind = true,
			},
		},
		config = true,
	},
}

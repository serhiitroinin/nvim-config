return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local gitsigns = require("gitsigns")

		gitsigns.setup({
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 1000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			max_file_length = 40000,
			preview_config = {
				border = "rounded",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation for git hunks
				map("n", "<leader>jh", function()
					if vim.wo.diff then
						vim.cmd("normal! ]c")
					else
						gs.next_hunk()
					end
				end, { desc = "Jump to next hunk" })

				map("n", "<leader>jH", function()
					if vim.wo.diff then
						vim.cmd("normal! [c")
					else
						gs.prev_hunk()
					end
				end, { desc = "Jump to previous hunk" })

				-- Actions (using leader+g prefix for git operations)
				map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
				map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
				map("v", "<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage hunk" })
				map("v", "<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset hunk" })
				map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
				map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
				map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
				map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
				map("n", "<leader>gB", function()
					gs.blame_line({ full = true })
				end, { desc = "Blame line (full)" })
				map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
				map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
				map("n", "<leader>gD", function()
					gs.diffthis("~")
				end, { desc = "Diff this ~" })
				map("n", "<leader>gt", gs.toggle_deleted, { desc = "Toggle deleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })

				-- Git history browser
				map("n", "<leader>gh", function()
					vim.cmd("Telescope git_commits")
				end, { desc = "Git history" })

				map("n", "<leader>gH", function()
					vim.cmd("Telescope git_bcommits")
				end, { desc = "Buffer git history" })
			end,
		})
	end,
}

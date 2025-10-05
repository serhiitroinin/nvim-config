-- =============================================
-- NEOVIM KEYMAPS - After Plugin Loading
-- =============================================
-- This file loads AFTER all plugins to ensure functions are available

local ok, wk = pcall(require, "which-key")
if not ok then
  vim.notify("Which-key not found", vim.log.levels.WARN)
  return
end

-- Helper function to set keymaps
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- =============================================
-- TELESCOPE KEYMAPS (Find)
-- =============================================
local telescope_ok, telescope_builtin = pcall(require, "telescope.builtin")
if telescope_ok then
  -- Core finding operations
  map("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files" })
  map("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Live grep (search text)" })
  map("n", "<leader>fb", telescope_builtin.buffers, { desc = "Find buffers" })
  map("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Help tags" })
  map("n", "<leader>fs", telescope_builtin.grep_string, { desc = "Search current word" })
  map("n", "<leader>fc", telescope_builtin.commands, { desc = "Commands" })
  map("n", "<leader>fo", telescope_builtin.oldfiles, { desc = "Recent files" })
  map("n", "<leader>fz", telescope_builtin.current_buffer_fuzzy_find, { desc = "Fuzzy find in buffer" })
  map("n", "<leader>fd", telescope_builtin.diagnostics, { desc = "Find diagnostics" })
  map("n", "<leader>fr", telescope_builtin.resume, { desc = "Resume last search" })
  map("n", "<leader>fk", telescope_builtin.keymaps, { desc = "Find keymaps" })
  map("n", "<leader>fm", telescope_builtin.marks, { desc = "Find marks" })
  map("n", "<leader>fR", telescope_builtin.registers, { desc = "Find registers" })

  -- Custom grep with input
  map("n", "<leader>f/", function()
    telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") })
  end, { desc = "Grep with input" })

  -- Project-wide search
  map("n", "<leader>fp", function()
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if vim.v.shell_error == 0 then
      telescope_builtin.find_files({ cwd = git_root })
    else
      telescope_builtin.find_files()
    end
  end, { desc = "Find in project root" })

  map("n", "<leader>fP", function()
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if vim.v.shell_error == 0 then
      telescope_builtin.live_grep({ cwd = git_root })
    else
      telescope_builtin.live_grep()
    end
  end, { desc = "Grep in project root" })

  -- Git operations
  map("n", "<leader>gh", telescope_builtin.git_commits, { desc = "Git commit history" })
  map("n", "<leader>gH", telescope_builtin.git_bcommits, { desc = "Git buffer history" })
  map("n", "<leader>gb", telescope_builtin.git_branches, { desc = "Git branches" })
  map("n", "<leader>gs", telescope_builtin.git_status, { desc = "Git status" })
  map("n", "<leader>gS", telescope_builtin.git_stash, { desc = "Git stash" })

  local yazi_ok, yazi = pcall(require, "yazi")
  if yazi_ok then
    map("n", "<leader>fy", function()
      yazi.yazi()
    end, { desc = "File manager (Yazi)" })
    map("n", "<leader>fY", function()
      yazi.yazi(nil, vim.fn.getcwd())
    end, { desc = "File manager @ project root" })
  end

  -- LSP operations with Telescope
  map("n", "<leader>lr", telescope_builtin.lsp_references, { desc = "LSP references" })
  map("n", "gr", telescope_builtin.lsp_references, { desc = "Go to references" })
  map("n", "gi", telescope_builtin.lsp_implementations, { desc = "Go to implementations" })
  map("n", "gt", telescope_builtin.lsp_type_definitions, { desc = "Go to type definitions" })
  map("n", "<leader>ls", telescope_builtin.lsp_document_symbols, { desc = "Document symbols" })
  map("n", "<leader>lw", telescope_builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
  map("n", "<leader>ld", telescope_builtin.lsp_definitions, { desc = "LSP definitions" })

  -- Diagnostics with Telescope
  map("n", "<leader>dd", function()
    telescope_builtin.diagnostics({ bufnr = 0 })
  end, { desc = "Document diagnostics" })
  map("n", "<leader>dw", telescope_builtin.diagnostics, { desc = "Workspace diagnostics" })
else
  vim.notify("Telescope not found", vim.log.levels.WARN)
end

-- =============================================
-- LSP KEYMAPS
-- =============================================
-- These are set in on_attach in lsp-config.lua but we'll ensure they're registered with which-key
wk.add({
  -- Code actions group
  { "<leader>c", group = "Code Actions" },
  { "<leader>ca", desc = "Code action" },
  { "<leader>cf", desc = "Quick fix" },
  { "<leader>cr", desc = "Rename" },
  { "<leader>ci", desc = "Organize imports" },
  { "<leader>cm", desc = "Add missing imports" },
  { "<leader>cu", desc = "Remove unused imports" },

  -- LSP group
  { "<leader>l", group = "LSP" },
  { "<leader>li", desc = "LSP info" },
  { "<leader>lr", desc = "LSP restart" },
  { "<leader>ll", desc = "LSP log" },
  { "<leader>ls", desc = "Document symbols" },
  { "<leader>lw", desc = "Workspace symbols" },
  { "<leader>ld", desc = "LSP definitions" },

  -- Navigation
  { "gd", desc = "Go to definition" },
  { "gD", desc = "Go to declaration" },
  { "gi", desc = "Go to implementation" },
  { "gt", desc = "Go to type definition" },
  { "gr", desc = "Go to references" },
  { "gb", desc = "Go back (navigation)" },
  { "gf", desc = "Go forward (navigation)" },
  { "K", desc = "Hover documentation" },
  { "<leader>K", desc = "Hover (persistent)" },
})

-- =============================================
-- HARPOON KEYMAPS
-- =============================================
local harpoon_ok, harpoon = pcall(require, "harpoon")
if harpoon_ok then
  map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add to Harpoon" })
  map("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
  map("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
  map("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
  map("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
  map("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
  map("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon next" })
  map("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon previous" })
end

-- =============================================
-- GITSIGNS KEYMAPS
-- =============================================
local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if gitsigns_ok then
  map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
  map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
  map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
  map("n", "<leader>gss", gitsigns.stage_hunk, { desc = "Stage hunk" })
  map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
  map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
  map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff this" })
  map("n", "<leader>gD", function() gitsigns.diffthis("~") end, { desc = "Diff this ~" })
  map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
  map("n", "<leader>gtd", gitsigns.toggle_deleted, { desc = "Toggle deleted" })

  -- Navigation
  map("n", "]h", gitsigns.next_hunk, { desc = "Next hunk" })
  map("n", "[h", gitsigns.prev_hunk, { desc = "Previous hunk" })
end

-- =============================================
-- TESTING KEYMAPS
-- =============================================
local neotest_ok, neotest = pcall(require, "neotest")
if neotest_ok then
  map("n", "<leader>tn", function() neotest.run.run() end, { desc = "Test nearest" })
  map("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Test file" })
  map("n", "<leader>ts", function() neotest.run.stop() end, { desc = "Stop test" })
  map("n", "<leader>ta", function() neotest.run.attach() end, { desc = "Attach to test" })
  map("n", "<leader>to", function() neotest.output.open({ enter = true }) end, { desc = "Test output" })
  map("n", "<leader>tO", function() neotest.output_panel.toggle() end, { desc = "Test output panel" })
  map("n", "<leader>tw", function() neotest.watch.toggle(vim.fn.expand("%")) end, { desc = "Watch test file" })
  map("n", "<leader>tW", function() neotest.watch.toggle() end, { desc = "Watch nearest test" })
end

-- =============================================
-- WRITING MODE KEYMAPS
-- =============================================
map("n", "<leader>zz", "<cmd>Goyo<cr>", { desc = "Toggle Zen Writing Mode (Goyo)" })

-- =============================================
-- ADDITIONAL WHICH-KEY REGISTRATIONS
-- =============================================
wk.add({
  -- Main groups
  { "<leader>f", group = "Find (Telescope)" },
  { "<leader>g", group = "Git" },
  { "<leader>h", group = "Harpoon/Help" },
  { "<leader>d", group = "Diagnostics" },
  { "<leader>t", group = "Testing" },
  { "<leader>x", desc = "Diagnostics (Snacks)" },
  { "<leader>xx", desc = "Diagnostics (workspace)" },
  { "<leader>xX", desc = "Diagnostics (buffer)" },
  { "<leader>o", group = "Organize/Outline" },
  { "<leader>a", group = "AI/Add imports" },
  { "<leader>r", group = "Rename/Remove" },
  { "<leader>n", group = "Notifications" },
  { "<leader>nh", desc = "Notification history" },
  { "<leader>nc", desc = "Clear notifications" },
  { "<leader>;", desc = "Dashboard" },
  { "<leader>p", group = "Project" },
  { "<leader>s", group = "Session/Search" },
  { "<leader>ps", desc = "Session: save" },
  { "<leader>pr", desc = "Session: restore" },
  { "<leader>pl", desc = "Session: restore last" },
  { "<leader>px", desc = "Session: stop tracking" },
  { "<leader>u", group = "UI/Utils" },
  { "<leader>v", group = "View/Vim" },
  { "<leader>z", group = "Fold/Zen" },
  { "<leader>fe", desc = "Explorer (Snacks)" },
  { "<leader>fE", desc = "Explorer (Snacks root)" },
  { "<leader>f.", desc = "Explorer (Snacks float)" },
  { "<leader>fx", desc = "Close explorers" },
  { "<leader>fy", desc = "Yazi file manager" },
  { "<leader>fY", desc = "Yazi file manager (root)" },
  { "<leader>cs", desc = "Symbols" },
  { "<leader>Tf", desc = "Terminal (float)" },
  { "<leader>Th", desc = "Terminal (horizontal)" },
  { "<leader>Tv", desc = "Terminal (vertical)" },
  { "<leader>Tn", desc = "Node REPL" },
  { "<leader>Tp", desc = "Python REPL" },

  -- Special keys
  { "<leader>w", desc = "Write/Save" },
  { "<leader>q", desc = "Quit" },
  { "<leader>Q", desc = "Quit all" },
  { "<leader>x", desc = "Save and quit" },
  { "<leader><space>", desc = "Clear search highlight" },
  { "<leader>?", desc = "Show keymaps reference" },
  { "<leader>S", desc = "Simple replace word" },
  { "<leader>y", desc = "Yank to clipboard" },
  { "<leader>Y", desc = "Yank line to clipboard" },
  { "<leader>p", desc = "Paste from clipboard" },
  { "<leader>d", desc = "Delete without yank" },

  -- Git subgroups
  { "<leader>gt", group = "Git toggle" },
  { "<leader>gs", group = "Git stage/status" },
})

-- =============================================
-- CONFIRMATION MESSAGE
-- =============================================

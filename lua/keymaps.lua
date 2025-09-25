-- =============================================
-- NEOVIM KEYMAPS - Organized Configuration
-- =============================================
-- Leader key is set to space in vim-options.lua

local M = {}

-- Helper function to set keymaps
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- =============================================
-- KEYMAP GROUPS
-- =============================================

M.general = {
  -- File Operations (w = write, q = quit)
  ["<leader>w"] = { ":w<CR>", "Save file" },
  ["<leader>q"] = { ":q<CR>", "Quit" },
  ["<leader>Q"] = { ":qa<CR>", "Quit all" },
  ["<leader>x"] = { ":x<CR>", "Save and quit" },

  -- Clear search highlight
  ["<leader><space>"] = { ":nohlsearch<CR>", "Clear search highlight" },

  -- Better window navigation (using Ctrl)
  ["<C-h>"] = { "<C-w>h", "Navigate left" },
  ["<C-j>"] = { "<C-w>j", "Navigate down" },
  ["<C-k>"] = { "<C-w>k", "Navigate up" },
  ["<C-l>"] = { "<C-w>l", "Navigate right" },

  -- Centered navigation
  ["<C-d>"] = { "<C-d>zz", "Scroll down centered" },
  ["<C-u>"] = { "<C-u>zz", "Scroll up centered" },
  ["n"] = { "nzzzv", "Next search centered" },
  ["N"] = { "Nzzzv", "Previous search centered" },

  -- Line manipulation
  ["J"] = { "mzJ`z", "Join lines (cursor stays)" },

  -- Disable Q
  ["Q"] = { "<nop>", "Disabled" },
}

M.visual = {
  -- Move lines up/down
  ["J"] = { ":m '>+1<CR>gv=gv", "Move line down" },
  ["K"] = { ":m '<-2<CR>gv=gv", "Move line up" },

  -- Better paste (doesn't yank replaced text)
  ["<leader>p"] = { [["_dP]], "Paste without yank" },

  -- System clipboard
  ["<leader>y"] = { [["+y]], "Copy to system clipboard" },
  ["<leader>d"] = { [["_d]], "Delete without yank" },
}

-- File Explorer (e = explorer)
M.file_explorer = {
  ["<leader>fe"] = { ":lua require('snacks').explorer.open({ position = 'left', width = 40 })<CR>", "Explorer (Snacks)" },
  ["<leader>fE"] = { ":lua require('snacks').explorer.open({ dir = vim.fn.getcwd(), position = 'left', width = 40 })<CR>", "Explorer project root" },
  ["<leader>f."] = { ":lua require('snacks').explorer.open({ dir = vim.fn.expand('%:p:h'), focus = false, position = 'float' })<CR>", "Explorer float" },
  ["<leader>fx"] = { ":lua require('snacks').explorer.close_all()<CR>", "Close explorers" },
  ["<leader>fy"] = { ":lua require('yazi').yazi()<CR>", "Yazi file manager" },
  ["<leader>fY"] = { ":lua require('yazi').yazi(nil, vim.fn.getcwd())<CR>", "Yazi project root" },
}

-- Finding/Searching (f = find)
M.telescope = {
  ["<leader>ff"] = { "Find files", "telescope.find_files" },
  ["<leader>fg"] = { "Live grep", "telescope.live_grep" },
  ["<leader>fb"] = { "Find buffers", "telescope.buffers" },
  ["<leader>fh"] = { "Help tags", "telescope.help_tags" },
  ["<leader>fs"] = { "Grep string under cursor", "telescope.grep_string" },
  ["<leader>fc"] = { "Commands", "telescope.commands" },
  ["<leader>fo"] = { "Recent files", "telescope.oldfiles" },
  ["<leader>fz"] = { "Fuzzy find in buffer", "telescope.current_buffer_fuzzy_find" },
  ["<leader>fr"] = { "Resume last search", "telescope.resume" },
  ["<leader>f/"] = { "Grep with input", "telescope.grep_input" },
  ["<leader>fp"] = { "Find in project", "telescope.project_files" },
}

-- Git operations (g = git)
M.git = {
  ["<leader>gst"] = { ":Git<CR>", "Git status (fugitive)" },
  ["<leader>gb"] = { "Toggle line blame", "gitsigns.toggle_current_line_blame" },
  ["<leader>gd"] = { "Diff this", "gitsigns.diffthis" },
  ["<leader>gD"] = { "Diff this ~", "gitsigns.diffthis_tilde" },
  ["<leader>gh"] = { "Git history", "telescope.git_commits" },
  ["<leader>gH"] = { "Buffer git history", "telescope.git_bcommits" },
  ["<leader>gp"] = { "Preview hunk", "gitsigns.preview_hunk" },
  ["<leader>gr"] = { "Reset hunk", "gitsigns.reset_hunk" },
  ["<leader>gR"] = { "Reset buffer", "gitsigns.reset_buffer" },
  ["<leader>gs"] = { "Stage hunk", "gitsigns.stage_hunk" },
  ["<leader>gS"] = { "Stage buffer", "gitsigns.stage_buffer" },
  ["<leader>gu"] = { "Undo stage hunk", "gitsigns.undo_stage_hunk" },
  ["<leader>gtb"] = { "Toggle line blame", "gitsigns.toggle_current_line_blame" },
  ["<leader>gtd"] = { "Toggle deleted", "gitsigns.toggle_deleted" },
}

-- Harpoon (h = harpoon)
M.harpoon = {
  ["<leader>ha"] = { "Add to Harpoon", "harpoon.add" },
  ["<leader>hm"] = { "Harpoon menu", "harpoon.menu" },
  ["<leader>h1"] = { "Harpoon file 1", "harpoon.nav_file_1" },
  ["<leader>h2"] = { "Harpoon file 2", "harpoon.nav_file_2" },
  ["<leader>h3"] = { "Harpoon file 3", "harpoon.nav_file_3" },
  ["<leader>h4"] = { "Harpoon file 4", "harpoon.nav_file_4" },
  ["<leader>hn"] = { "Harpoon next", "harpoon.nav_next" },
  ["<leader>hp"] = { "Harpoon previous", "harpoon.nav_prev" },
}

-- LSP/Code actions (c = code, l = lsp)
M.lsp = {
  -- Code actions
  ["<leader>ca"] = { "Code action", "lsp.code_action" },
  ["<leader>cf"] = { "Quick fix", "lsp.quick_fix" },
  ["<leader>cr"] = { "Rename", "lsp.rename" },
  ["<leader>ci"] = { "Organize imports", "typescript.organize_imports" },
  ["<leader>cm"] = { "Add missing imports", "typescript.add_missing_imports" },
  ["<leader>cu"] = { "Remove unused imports", "typescript.remove_unused" },

  -- LSP info
  ["<leader>li"] = { "LSP info", "lsp.info" },
  ["<leader>lr"] = { "LSP restart", "lsp.restart" },
  ["<leader>ll"] = { "LSP log", "lsp.log" },

  -- Symbol search
  ["<leader>ls"] = { "Document symbols", "telescope.lsp_document_symbols" },
  ["<leader>lw"] = { "Workspace symbols", "telescope.lsp_workspace_symbols" },

  -- Hover documentation
  ["K"] = { "Hover", "lsp.hover" },
  ["<leader>K"] = { "Hover (persistent)", "lsp.hover_persistent" },

  -- Go to definitions
  ["gd"] = { "Go to definition", "lsp.definition" },
  ["gD"] = { "Go to declaration", "lsp.declaration" },
  ["gi"] = { "Go to implementation", "lsp.implementation" },
  ["gt"] = { "Go to type definition", "lsp.type_definition" },
  ["gr"] = { "Go to references", "telescope.lsp_references" },
  ["gb"] = { "Go back", "navigate.back" },
  ["gf"] = { "Go forward", "navigate.forward" },
}

-- Diagnostics (d = diagnostics)
M.diagnostics = {
  ["<leader>dd"] = { "Document diagnostics", "telescope.diagnostics_document" },
  ["<leader>dw"] = { "Workspace diagnostics", "telescope.diagnostics_workspace" },
  ["<leader>df"] = { "Diagnostic float", "diagnostic.open_float" },
  ["<leader>dn"] = { "Next diagnostic", "diagnostic.goto_next" },
  ["<leader>dp"] = { "Previous diagnostic", "diagnostic.goto_prev" },
  ["<leader>de"] = { "Next error", "diagnostic.goto_next_error" },
  ["<leader>dE"] = { "Previous error", "diagnostic.goto_prev_error" },
}

-- Testing (t = test)
M.testing = {
  ["<leader>tn"] = { "Test nearest", "test.nearest" },
  ["<leader>tf"] = { "Test file", "test.file" },
  ["<leader>tl"] = { "Test last", "test.last" },
  ["<leader>ta"] = { "Test all", "test.suite" },
  ["<leader>to"] = { "Show test output", "test.output" },
}



-- Search and Replace (s = search/replace)
M.search_replace = {
  ["<leader>sh"] = { "Search history", "telescope.search_history" },
  ["<leader>S"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace word under cursor" },
}



-- Comments (already handled by Comment.nvim with gcc/gbc)
M.comments = {
  ["<leader>cc"] = { "gcc", "Toggle line comment", remap = true },
  ["<leader>cb"] = { "gbc", "Toggle block comment", remap = true },
}

-- =============================================
-- KEYMAP REFERENCE SYSTEM
-- =============================================

M.show_keymaps = function()
  local lines = {
    "╔═══════════════════════════════════════════════════════════════╗",
    "║                    NEOVIM KEYMAPS REFERENCE                      ║",
    "╚═══════════════════════════════════════════════════════════════╝",
    "",
    "┌─── General ─────────────────────────────────────────────────────┐",
    "│ <leader>w/q   Save/Quit          │ <leader><space>  Clear search│",
    "│ Ctrl+h/j/k/l  Navigate windows   │ Ctrl+d/u         Scroll      │",
    "└─────────────────────────────────────────────────────────────────┘",
    "",
    "┌─── Finding (f) ─────────────────────────────────────────────────┐",
    "│ <leader>ff    Find files         │ <leader>fg       Live grep   │",
    "│ <leader>fb    Find buffers       │ <leader>fo       Recent files │",
    "│ <leader>fs    Search word        │ <leader>fz       Fuzzy buffer│",
    "└─────────────────────────────────────────────────────────────────┘",
    "",
    "┌─── Git (g) ─────────────────────────────────────────────────────┐",
    "│ <leader>gb    Toggle blame       │ <leader>gh       Git history │",
    "│ <leader>gp    Preview hunk       │ <leader>gs/gr    Stage/Reset │",
    "└─────────────────────────────────────────────────────────────────┘",
    "",
    "┌─── Code/LSP (c/l) ──────────────────────────────────────────────┐",
    "│ <leader>ca    Code action        │ <leader>cr       Rename      │",
    "│ <leader>ci    Organize imports   │ K/<leader>K      Hover       │",
    "│ gd/gi/gt/gr   Go to def/impl/type/refs                          │",
    "└─────────────────────────────────────────────────────────────────┘",
    "",
    "┌─── Diagnostics (d) ─────────────────────────────────────────────┐",
    "│ <leader>dd    Doc diagnostics    │ <leader>dn/dp    Next/Prev   │",
    "│ <leader>de    Next error         │ <leader>df       Float       │",
    "└─────────────────────────────────────────────────────────────────┘",
    "",
    "┌─── Testing (t) ─────────────────────────────────────────────────┐",
    "│ <leader>tn    Test nearest       │ <leader>tf       Test file   │",
    "│ <leader>ta    Test all           │ <leader>tl       Test last   │",
    "│ <leader>td    Debug test         │ <leader>to       Test output │",
    "└─────────────────────────────────────────────────────────────────┘",
    "",
    "┌─── Search/Replace (s) ──────────────────────────────────────────┐",
    "│ <leader>sr    Search & replace   │ <leader>sw       Search word │",
    "│ <leader>sp    Search in file     │ <leader>sh       History     │",
    "└─────────────────────────────────────────────────────────────────┘",
    "",
    "┌─── Harpoon (h) ─────────────────────────────────────────────────┐",
    "│ <leader>ha    Add file           │ <leader>hm       Menu        │",
    "│ <leader>h1-4  Go to file 1-4     │ <leader>hn/hp    Next/Prev   │",
    "└─────────────────────────────────────────────────────────────────┘",
    "",
    "Press 'q' to close this window",
  }

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'keymap-help')

  -- Add lines to buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Make buffer non-modifiable
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)

  -- Calculate window size
  local width = 68
  local height = #lines

  -- Get editor dimensions
  local ui_width = vim.api.nvim_get_option("columns")
  local ui_height = vim.api.nvim_get_option("lines")

  -- Calculate starting position
  local col = math.floor((ui_width - width) / 2)
  local row = math.floor((ui_height - height) / 2)

  -- Set window options
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
    title = ' Keymaps Reference ',
    title_pos = 'center',
  }

  -- Create floating window
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Set window-local keymaps
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', { noremap = true, silent = true })

  -- Add syntax highlighting
  vim.api.nvim_win_set_option(win, 'winhl', 'Normal:NormalFloat')
end

-- Create command to show keymaps
vim.api.nvim_create_user_command('Keymaps', M.show_keymaps, {})

-- Set the main keymap to show the reference
map('n', '<leader>?', M.show_keymaps, { desc = "Show keymaps reference" })
map('n', '<leader>hk', M.show_keymaps, { desc = "Help: Keymaps" })

return M

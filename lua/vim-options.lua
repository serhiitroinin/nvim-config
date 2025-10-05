vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
local undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(undodir, "p")
vim.opt.undodir = undodir
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- Disable semantic tokens for TypeScript servers where they are noisy
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    if client.server_capabilities.semanticTokensProvider
      and (client.name == "tsserver" or client.name == "typescript-language-server" or client.name == "vtsls") then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.wrap = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.clipboard = "unnamedplus"

vim.opt.mouse = "a"

vim.opt.cursorline = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })


vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>", { desc = "Clear search highlight" })

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Custom quit all command that handles terminals
vim.api.nvim_create_user_command("Qa", function()
  -- First, close all terminal buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
      if buftype == "terminal" then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
  -- Then quit all
  vim.cmd("qa")
end, { desc = "Quit all (including terminals)" })

vim.api.nvim_create_user_command("Wqa", function()
  -- Save all normal buffers
  vim.cmd("wa")
  -- Close all terminal buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
      if buftype == "terminal" then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
  -- Then quit all
  vim.cmd("qa")
end, { desc = "Write and quit all (including terminals)" })

vim.keymap.set("n", "<leader>mp", ':!glow "%"<CR>', { desc = "Preview markdown with glow" })
vim.keymap.set("n", "<leader>mP", ':terminal glow "%"<CR>', { desc = "Preview markdown in terminal split" })

-- Set conceallevel for Obsidian.nvim UI features
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"

-- Enhanced diagnostic configuration

-- Load diagnostic deduplication
require("diagnostic-dedupe")

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 4,
    source = "if_many",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
    priority = 10,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Diagnostic navigation is handled in lsp-config.lua
-- Using <leader>dn and <leader>dp for consistency

-- Enable soft wrap for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "md" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
  end,
})

-- Auto-reload files when changed externally
vim.opt.autoread = true

-- Trigger checktime when files change on disk
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- Notification when file changes externally
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})

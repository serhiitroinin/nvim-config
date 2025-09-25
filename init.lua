require("vim-options")
require("keymaps")
require("theme-utils")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins.core" },
  { import = "plugins.lsp" },
  { import = "plugins.navigation" },
  { import = "plugins.editor" },
  { import = "plugins.git" },
  { import = "plugins.testing" },
  { import = "plugins.productivity" },
  { import = "plugins.extras" },
}, {
  change_detection = {
    notify = false,
  },
})

return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Suppress the deprecation warning about 'framework'
      -- This is an internal nvim-lspconfig warning that will be resolved in future versions
      local notify = vim.notify
      vim.notify = function(msg, ...)
        if msg:match("require%('lspconfig'%).*framework.*deprecated") then
          return
        end
        return notify(msg, ...)
      end
    end,
  },
}
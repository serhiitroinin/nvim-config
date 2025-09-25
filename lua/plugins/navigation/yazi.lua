return {
  {
    "mikavilpas/yazi.nvim",
    cmd = { "Yazi" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      open_for_directories = true,
    },
    config = function(_, opts)
      require("yazi").setup(opts)
    end,
  },
}

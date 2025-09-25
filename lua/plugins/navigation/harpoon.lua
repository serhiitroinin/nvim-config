return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    -- Keymaps are now handled in after/plugin/keymaps.lua for consistency
    -- Using <leader>h prefix for all Harpoon operations
  end,
}
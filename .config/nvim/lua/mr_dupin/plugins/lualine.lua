-- https://github.com/nvim-lualine/lualine.nvim
-- TODO: Tweak config
return{
  "nvim-lualine/lualine.nvim",
  dependencies = {"nvim-tree/nvim-web-devicons"},
  config = function()
    local lualine = require("lualine")

    lualine.setup({
      theme = "ayu_dark",
    })
  end
}

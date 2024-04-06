-- https://github.com/akinsho/bufferline.nvim
-- TODO: Tweak config
return{
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons"},
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      separator_style = "slant",
    },
  },
}

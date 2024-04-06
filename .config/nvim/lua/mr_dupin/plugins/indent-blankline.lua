-- https://github.com/lukas-reineke/indent-blankline.nvim
-- TODO: Tweak config
return{
  "lukas-reineke/indent-blankline.nvim",
  event = {"BufReadPre", "BufNewFile"},
  main = "ibl",
  opts = {
    indent = { char = "|"},
  },
}

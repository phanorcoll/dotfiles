-- url: https://github.com/catppuccino/nvim
-- desc: A dark and vibrant color scheme for Neovim
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      term_colors = true
    })
    vim.cmd.colorscheme "catppuccin-mocha"
  end,
}

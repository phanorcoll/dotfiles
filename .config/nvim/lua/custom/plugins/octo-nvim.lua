-- https://github.com/pwntester/octo.nvim
-- NOTE: workaround for current bug
-- https://github.com/pwntester/octo.nvim/issues/466
vim.g.octo_viewer = "phanorcoll"
return {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require "octo".setup()
  end
}

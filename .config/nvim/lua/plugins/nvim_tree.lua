return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys={
    {'<leader>ee', "<cmd>NvimTreeFindFileToggle<cr>", desc = 'Toggle Nvim Tree' },
    {'<leader>er', '<cmd>NvimTreeRefresh<CR>',  desc = 'Refresh file explorer' },
  },
  config = function()
    require("nvim-tree").setup {}
  end,
}

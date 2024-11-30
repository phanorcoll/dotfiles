return{
  'akinsho/bufferline.nvim', 
  version = "*", 
  dependencies = 'nvim-tree/nvim-web-devicons',
  keys ={
    {"<leader>n","<cmd>bn<cr>",  desc = 'Move to next buffer' },
    {"<leader>p","<cmd>bp<cr>",  desc = 'Move to previous buffer' },
    {"<leader>x","<cmd>bd<cr>",  desc = 'Close buffer' },
  },
  config = function()
    require("bufferline").setup{}
  end
}

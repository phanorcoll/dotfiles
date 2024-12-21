-- url: https://githob.com/akinsho/bufferline.nvim
-- desc: Bufferline is a snazzy buffer line for Neovim
vim.keymap.set('n', '<leader>n', '<cmd>bn<cr>', { desc = 'Move to next buffer' })
vim.keymap.set('n', '<leader>p', '<cmd>bp<cr>', { desc = 'Move to previous buffer' })
vim.keymap.set('n', '<leader>cb', '<cmd>bd<cr>', { desc = 'Close buffer' })
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {}
  end,
}

-- https://github.com/ethanholz/freeze.nvim
return {
  'ethanholz/freeze.nvim',
  config = true,
  vim.keymap.set('v', '<leader>z', ':Freeze<cr>', { silent = true, desc = 'Freeze selection' }),
  vim.keymap.set('n', '<leader>zl', ':FreezeLine<cr>', { silent = true, desc = 'Freeze current line' }),
}

-- https://github.com/folke/trouble.nvim
return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/todo-comments.nvim' },
  keys = {
    { '<leader>dx', '<cmd>TroubleToggle<CR>', desc = 'Open/close trouble list' },
    { '<leader>dw', '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Open workspace trouble' },
    { '<leader>dd', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'Open document trouble list' },
    { '<leader>dq', '<cmd>TroubleToggle quickfix<CR>', desc = 'Open trouble quickfix list' },
    { '<leader>dl', '<cmd>TroubleToggle loclist<CR>', desc = 'Open trouble location list' },
    { '<leader>t', '<cmd>TodoTrouble<CR>', desc = 'Open TODOs in trouble' },
  },
}

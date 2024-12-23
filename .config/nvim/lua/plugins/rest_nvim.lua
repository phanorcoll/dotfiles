-- url: https://github.com/rest-nvim/rest.nvim
-- desc: HTTP client for Neovim inspired by Postman and HTTPie
return {
  'rest-nvim/rest.nvim',
  keys = {
    { '<leader>rr', '<cmd>Rest run<cr>', desc = 'Rest Run request under cursor' },
    { '<leader>ro', '<cmd>Rest run<cr>', desc = 'Rest Open result pane' },
  },
}

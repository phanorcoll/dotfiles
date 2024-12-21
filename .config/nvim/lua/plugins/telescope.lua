-- url: https://github.com/nvim-telescope/telescope.nvim
-- desc: Find, Filter, Preview, Pick. All lua, all the time.

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    require('telescope').setup {
      pickers = {
        find_files = {
          theme = 'ivy',
        },
      },
      extensions = {
        fzf = {},
      },
    }
    require('telescope').load_extension 'fzf'
  end,
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Telescope find files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Telescope live grep in working directory' },
    { '<leader><leader>', '<cmd>Telescope buffers<cr>', desc = 'Telescope buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Telescope help tags' },
    { '<leader>fo', '<cmd>Telescope oldfiles<cr>', desc = 'Telescope find old files' },
    { '<leader>gf', '<cmd>Telescope git_files<cr>', desc = 'Telescope find git files' },
    { '<leader>fw', '<cmd>Telescope grep_string<cr>', desc = 'Searches for the string under your cursor or selection in your current working directory' },
    { '<leader>sw', '<cmd>Telescope spell_suggest<cr>', desc = 'Lists spelling suggestions for the current word under the cursor ' },
  },
}

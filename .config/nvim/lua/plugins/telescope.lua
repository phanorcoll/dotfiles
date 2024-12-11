-- url: https://github.com/nvim-telescope/telescope.nvim
-- desc: Find, Filter, Preview, Pick. All lua, all the time.
local builtin = require('telescope.builtin')

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
        }
      },
      extensions = {
        fzf = {}
      }
    }
    require('telescope').load_extension('fzf')
  end,
  keys = {
    { '<leader>ff',       builtin.find_files, desc = 'Telescope find files' },
    { '<leader>fg',       builtin.live_grep,  desc = 'Telescope live grep' },
    { '<leader><leader>', builtin.buffers,    desc = 'Telescope buffers' },
    { '<leader>fh',       builtin.help_tags,  desc = 'Telescope help tags' },
    { '<leader>fo',       builtin.oldfiles,   desc = 'Telescope find old files' },
    { '<leader>gf',       builtin.git_files,  desc = 'Telescope find git files' },
  },
}

local builtin = require('telescope.builtin')

return {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      keys={
        {'<leader>ff', builtin.find_files,  desc = 'Telescope find files' },
        {'<leader>fg', builtin.live_grep,  desc = 'Telescope live grep' },
        {'n', '<leader>fb', builtin.buffers,  desc = 'Telescope buffers' },
        {'n', '<leader>fh', builtin.help_tags,  desc = 'Telescope help tags' },
        {'n', '<leader>fo', builtin.oldfiles,  desc = 'Telescope help tags' },
        {'n', '<leader>gf', builtin.git_files,  desc = 'Telescope help tags' },
      },
    }

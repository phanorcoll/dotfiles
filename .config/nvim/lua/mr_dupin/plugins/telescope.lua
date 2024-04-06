-- https://github.com/nvim-telescope/telescope.nvim
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'

    telescope.setup {
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
          },
        },
        sorting_strategy = 'ascending',
        path_display = { 'smart' },
        prompt_prefix = ' 󰥖  ', -- Set the prompt prefix for all pickers
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          prompt_title = 'Start Searching',
          -- layout_strategy = 'vertical',
          -- prompt_prefix = 'Find Files!!!: ', -- Override the prompt prefix for the find_files picker
        },
        oldfiles = {
          prompt_title = 'Recently Viewed',
        },
        buffers = {
          prompt_title = 'Opened files',
        },
        current_buffer_fuzzy_find = {
          prompt_title = 'Search in current file',
        },
        help_tags = {
          prompt_title = 'Search Help Docs',
        },
        diagnostics = {
          prompt_title = 'Search through Issues',
        },
      },
    }
    telescope.load_extension 'fzf'

    local keymap = vim.keymap
    keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Find files in project' })
    keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<CR>', { desc = 'Find recent files' })
    keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<CR>', { desc = 'Find string in project' })
    keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<CR>', { desc = 'Find string under cursor' })
    keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<CR>', { desc = 'Find TODOs' })
    keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
    keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
    keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Search Git Files' })
    keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
    keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
  end,
}

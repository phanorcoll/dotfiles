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

    -- Settings for with preview option
    local diagnostic_list = require('telescope.themes').get_dropdown {
      winblend = 20,
      width = require('telescope.config.resolve').resolve_width(0.6),
      prompt = 'oo ',
      results_height = 15,
      previewer = true,
      prompt_prefix = ' 󰥖  ', -- Set the prompt prefix for all pickers
    }
    local with_preview = {
      layout_strategy = 'horizontal',
      winblend = 20,
      results_title = false,
      -- preview_title = false,
      layout_config = {
        height = 0.6,
        width = 0.9,
        preview_width = 0.6,
        horizontal = {
          prompt_position = 'top',
        },
      },
      sorting_strategy = 'ascending',
      path_display = { 'smart' },
      prompt_prefix = ' 󰥖  ', -- Set the prompt prefix for all pickers
    }

    local center_list = require('telescope.themes').get_dropdown {
      winblend = 20,
      width = 0.5,
      -- prompt = ' ',
      results_height = 15,
      previewer = false,
      prompt_prefix = ' 󰥖  ', -- Set the prompt prefix for all pickers
    }

    telescope.setup {
      defaults = {
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
          find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
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
    keymap.set('n', '<leader>ff', function()
      require('telescope.builtin').find_files(with_preview)
    end, { desc = 'Find files in project' })
    keymap.set('n', '<leader>fr', function()
      require('telescope.builtin').oldfiles(with_preview)
    end, { desc = 'Find recent files' })
    keymap.set('n', '<leader>fs', function()
      require('telescope.builtin').live_grep(with_preview)
    end, { desc = 'Find string in project' })
    keymap.set('n', '<leader>fc', function()
      require('telescope.builtin').grep_string(center_list)
    end, { desc = 'Find string under cursor' })
    keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<CR>', { desc = 'Find TODOs' })
    keymap.set('n', '<leader><space>', function()
      require('telescope.builtin').buffers(center_list)
    end, { desc = 'Find existing buffers' })
    keymap.set('n', '<leader>/', function()
      require('telescope.builtin').current_buffer_fuzzy_find(center_list)
    end, { desc = '[/] Fuzzily search in current buffer' })
    keymap.set('n', '<leader>fg', function()
      require('telescope.builtin').git_files(center_list)
    end, { desc = 'Search Git Files' })
    keymap.set('n', '<leader>fh', function()
      require('telescope.builtin').help_tags(with_preview)
    end, { desc = 'Search Help' })
    keymap.set('n', '<leader>fd', function()
      require('telescope.builtin').diagnostics(diagnostic_list)
    end, { desc = 'Search Diagnostics' })
  end,
}

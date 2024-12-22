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
      defaults = {
        layout_config = {
          prompt_position = 'top',
          vertical = { width = 0.5 },
        },
        mappings = {
          i = {
            ['<esc>'] = require('telescope.actions').close,
            ['<C-h>'] = 'which_key',
          },
        },
      },
      pickers = {
        find_files = {
          theme = 'ivy',
        },
        grep_string = {
          theme = 'cursor',
        },
      },
      extensions = {
        fzf = {},
        emoji = {},
        gitmoji = {
          action = function(entry)
            local emoji = entry.value.value
            vim.ui.input({ prompt = 'Enter commit message: ' .. emoji .. ' ' }, function(msg)
              if not msg then
                return
              end
              local full_message = emoji .. ' ' .. msg
              vim.fn.setreg('+', full_message)
              vim.cmd 'Neogit commit'
            end)
          end,
        },
      },
    }

    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'emoji'
    require('telescope').load_extension 'gitmoji'
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
    { '<leader>em', '<cmd>Telescope emoji<cr>', desc = 'Lists emojis ' },
    { '<leader>gm', '<cmd>Telescope gitmoji<cr>', desc = 'Create commit header with gitmoji ' },
  },
}

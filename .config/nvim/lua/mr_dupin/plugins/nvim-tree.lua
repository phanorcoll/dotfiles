-- https://github.com/nvim-tree/nvim-tree.lua
-- :h nvim-tree
return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPugin = 1
    local api = require 'nvim-tree.api'
    api.events.subscribe(api.events.Event.FileCreated, function(file)
      vim.cmd('edit ' .. file.fname)
    end)

    -- TODO: Improve this function to show more of the name, not only 1 char
    local function label(path)
      path = path:gsub(os.getenv 'HOME', '~', 1)
      return path:gsub('([a-zA-Z])[a-z0-9]+', '%1') .. (path:match '[a-zA-Z]([a-z0-9]*)$' or '')
    end

    require('nvim-tree').setup {
      view = {
        width = 40,
        relativenumber = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = '󰁕 ',
              arrow_open = ' ',
            },
          },
        },
        root_folder_label = label,
        group_empty = label,
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        dotfiles = true,
      },
      git = {
        ignore = false,
      },
    }

    local function find_directory_and_focus()
      local actions = require 'telescope.actions'
      local action_state = require 'telescope.actions.state'

      local function open_nvim_tree(prompt_bufnr, _)
        actions.select_default:replace(function()
          local api = require 'nvim-tree.api'

          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          api.tree.open()
          api.tree.find_file(selection.cwd .. '/' .. selection.value)
        end)
        return true
      end

      require('telescope.builtin').find_files {
        find_command = { 'fd', '--type', 'directory', '--hidden', '--exclude', '.git/*' },
        attach_mappings = open_nvim_tree,
      }
    end

    -- keymapping
    local keymap = vim.keymap
    keymap.set('n', '<leader>ee', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
    keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'Open file explorer on current file' })
    keymap.set('n', '<leader>ec', '<cmd>NvimTreeCollapse<CR>', { desc = 'Collapse folders' })
    keymap.set('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>', { desc = 'Refresh file explorer' })
    keymap.set('n', 'fd', find_directory_and_focus)
  end,
}

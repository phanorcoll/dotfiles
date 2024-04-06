-- https://github.com/nvim-lualine/lualine.nvim
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  enabled = true,
  event = 'VeryLazy',
  opts = function()
    local icons = {
      diagnostics = {
        Error = ' ',
        Warn = ' ',
        Hint = ' ',
        Info = ' ',
      },
      git = {
        added = '',
        changed = '',
        deleted = '',
      },
    }
    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn', 'info', 'hint' },
      symbols = {
        error = icons.diagnostics.Error,
        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Info,
        warn = icons.diagnostics.Warn,
      },
      colored = true,
      update_in_insert = false,
      always_visible = false,
    }

    local diff = {
      'diff',
      symbols = {
        added = icons.git.added .. ' ',
        untracked = icons.git.added .. ' ',
        modified = icons.git.changed .. ' ',
        removed = icons.git.deleted .. ' ',
      },
      colored = true,
      always_visible = false,
      source = function()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end,
    }

    local iceberg_no_bd = require 'lualine.themes.iceberg_dark'

    -- Change the background of lualine_c section for normal mode
    iceberg_no_bd.normal.c.bg = 'none'
    return {
      options = {
        theme = iceberg_no_bd,
        icons_enabled = true,
        globalstatus = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { statusline = { 'dashboard', 'lazy', 'alpha' } },
      },
      sections = {
        lualine_a = {},
        lualine_b = { 'branch' },
        lualine_c = {},
        lualine_x = { diff, diagnostics, 'filename', 'filetype' },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}

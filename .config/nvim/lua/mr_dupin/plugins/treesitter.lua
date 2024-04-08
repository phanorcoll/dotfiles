-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  config = function()
    local treesitter = require 'nvim-treesitter.configs'
    treesitter.setup {
      modules = {},
      highlight = { -- enable syntax highlighting
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indend = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
      ensure_installed = {
        'json',
        'javascript',
        'typescript',
        'tsx',
        'yaml',
        'html',
        'css',
        'markdown',
        'markdown_inline',
        'svelte',
        'bash',
        'lua',
        'vim',
        'dockerfile',
        'gitignore',
        'gitcommit',
        'go',
        'gomod',
        'gotmpl',
        'make',
        'regex',
        'rust',
        'templ',
        'terraform',
        'tmux',
        'toml',
      },
      sync_install = false,
      ignore_install = {},
      auto_install = true,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    }
  end,
}

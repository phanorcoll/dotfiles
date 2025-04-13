-- url: https://github.com/nvim-treesitter/nvim-treesitter
-- desc: Treesitter configurations
return{
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  config = function () 
    local configs = require("nvim-treesitter.configs")

    configs.setup({
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
        'vimdoc',
        'lua',
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
        'http',
        'sql',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<Enter>", -- set to `false` to disable one of the mappings
          node_incremental = "<Enter>",
          scope_incremental = "grc",
          node_decremental = "<Backspace>",
        },
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },  
    })
    --Folding
    -- vim.wo.foldmethod = 'expr'
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end
}

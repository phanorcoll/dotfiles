-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp/wiki
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
    },
    'saadparwaiz1/cmp_luasnip', -- for autocompletion
    'rafamadriz/friendly-snippets', -- snippers
    -- 'onsails/lspkind.nvim', -- pictogram
    {
      'zbirenbaum/copilot-cmp',
      config = function()
        require('copilot_cmp').setup()
      end,
    },
  },
  config = function()
    -- local lspkind = require 'lspkind'
    -- lspkind.init()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    local kind_icons = {
      Text = '',
      Method = '󰆧',
      Function = '󰊕',
      Constructor = '',
      Field = '󰇽',
      Variable = '󰂡',
      Class = '󰠱',
      Interface = '',
      Module = '',
      Property = '󰜢',
      Unit = '',
      Value = '󰎠',
      Enum = '',
      Keyword = '󰌋',
      Snippet = '',
      Color = '󰏘',
      File = '󰈙',
      Reference = '',
      Folder = '󰉋',
      EnumMember = '',
      Constant = '󰏿',
      Struct = '',
      Event = '',
      Operator = '󰆕',
      TypeParameter = '󰅲',
      Copilot = '',
    }

    cmp.setup {
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm { select = true },
      },
      sources = cmp.config.sources {
        { name = 'copilot', group_index = 2 },
        { name = 'nvim_lua', group_index = 2 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'path', group_index = 2 },
        { name = 'luasnip', group_index = 2 },
        { name = 'buffer', group_index = 2, keyword_length = 5 },
        { name = 'vim-dadbod-completion', group_index = 2 },
      },
      formatting = {
        expandable_indicator = false,
        fields = { 'abbr', 'kind', 'menu' },
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format('%s  %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
          -- Source
          vim_item.menu = ({
            nvim_lsp = '[LSP]',
            nvim_lua = '[api]',
            luasnip = '[snip]',
            buffer = '[buffer]',
            path = '[path]',
            copilot = '[ai]',
            ['vim-dadbod-completion'] = '[dadbod]',
          })[entry.source.name]
          return vim_item
        end,
      },
      experimental = {
        ghost_text = true,
      },
    }
  end,
}

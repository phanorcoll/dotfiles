-- url: https://github.com/williamboman/mason.nvim
-- desc: Plugin manager for Neovim
return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {},
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/nvim-cmp',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
      },
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets', -- snippers
      {
        'zbirenbaum/copilot-cmp',
        config = function()
          require('copilot_cmp').setup()
        end,
      },
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      local cmp = require 'cmp'
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
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        completion = {
          completeopt = 'menu,menuone,preview,noselect',
        },
        sources = {
          { name = 'copilot' },
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        snippet = {
          expand = function(args)
            -- vim.snippet.expand(args.body) -- having this line will cause an error, duplicating the selection
            require('luasnip').lsp_expand(args.body)
          end,
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

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = 'path', option = { trailing_slash = true } }
      --   }, {
      --     { name = 'cmdline', option = { treat_trailing_slash = false } }
      --   })
      -- })
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      local lsp_defaults = require('lspconfig').util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities, require('cmp_nvim_lsp').default_capabilities())

      local buffer_autoformat = function(bufnr)
        local group = 'lsp_autoformat'
        vim.api.nvim_create_augroup(group, { clear = false })
        vim.api.nvim_clear_autocmds { group = group, buffer = bufnr }
      end

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local id = vim.tbl_get(event, 'data', 'client_id')
          local client = id and vim.lsp.get_client_by_id(id)
          if client == nil then
            return
          end

          local opts = { buffer = event.buf }

          opts.desc = 'Show documentation'
          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

          opts.desc = 'Show LSP definitions'
          vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)

          opts.desc = 'Go to declaration'
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)

          opts.desc = 'View Implementation'
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)

          opts.desc = 'Type definitions'
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)

          opts.desc = 'Show LSP references'
          vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)

          opts.desc = 'Show Signature Help'
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

          opts.desc = 'Rename everywhere'
          vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)

          opts.desc = 'Formar buffer'
          vim.keymap.set({ 'n', 'x' }, '<leader>fd', '<cmd>lua require("conform").format()<cr>', opts)

          opts.desc = 'Available code actions'
          vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

          opts.desc = 'Show buffer diagnostic'
          vim.keymap.set('n', 'D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

          opts.desc = 'Show line diagnostics'
          vim.keymap.set('n', 'd', vim.diagnostic.open_float, opts)

          opts.desc = 'Go to Previous diagnostic'
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

          opts.desc = 'Go to Next diagnostic'
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

          opts.desc = 'Restart LSP'
          vim.keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts)

          -- make sure there is at least one client with formatting capabilities
          if client.supports_method 'textDocument/formatting' then
            buffer_autoformat(event.buf)
          end
        end,
      })

      require('mason-lspconfig').setup {
        ensure_installed = {
          'lua_ls',
          'denols',
          'html',
          'htmx',
          'templ',
          'gopls',
          'cssls',
          'tailwindcss',
          'bashls',
          'dockerls',
          'docker_compose_language_service',
          'markdown_oxide',
          'yamlls',
        },
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          -- setup deno https://docs.deno.com/runtime/getting_started/setup_your_environment/#neovim-0.6%2B-using-the-built-in-language-server
          function(server_name)
            require('lspconfig')[server_name].setup {}
            -- require('lspconfig').ts_ls.setup {
            --   root_dir = require('lspconfig').util.root_pattern 'package.json',
            --   single_file_support = false,
            -- }
            require('lspconfig').denols.setup {
              cmd = { 'deno', 'lsp' },
              cmd_env = {
                NO_COLOR = false,
              },
              filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
              root_dir = require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc', '.git'),
              settings = {
                deno = {
                  enable = true,
                  lint = false,
                  suggest = {
                    imports = {
                      hosts = {
                        ['https://deno.land'] = true,
                      },
                    },
                  },
                },
              },
            }
            require('lspconfig').gopls.setup {
              cmd = { 'gopls' },
              -- on_attach = on_attach,
              capabilities = lsp_defaults.capabilities,
              settings = {
                gopls = {
                  experimentalPostfixCompletions = true,
                  analyses = {
                    unusedparams = true,
                    shadow = true,
                  },
                  staticcheck = true,
                },
              },
              init_options = {
                usePlaceholders = true,
              },
            }
          end,
        },
      }

      -- list of formatters & linters
      require('mason-tool-installer').setup {
        ensure_installed = {
          -- formatters
          'prettierd',
          'stylua',
          'gofumpt',
          'goimports',
          'golines',
          'jq',
          -- linters
          'revive',
          -- 'markdownlint',
          'jsonlint',
          -- 'eslint_d',
        },
        -- if set to true this will check each tool for updates. If updates
        -- are available the tool will be updated. This setting does not
        -- affect :MasonToolsUpdate or :MasonToolsInstall.
        -- Default: false
        auto_update = false,

        -- automatically install / update on startup. If set to false nothing
        -- will happen on startup. You can use :MasonToolsInstall or
        -- :MasonToolsUpdate to install tools and check for updates.
        -- Default: true
        run_on_start = true,

        -- set a delay (in ms) before the installation starts. This is only
        -- effective if run_on_start is set to true.
        -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
        -- Default: 0
        start_delay = 2000, -- 3 second delay

        -- Only attempt to install if 'debounce_hours' number of hours has
        -- elapsed since the last time Neovim was started. This stores a
        -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
        -- This is only relevant when you are using 'run_on_start'. It has no
        -- effect when running manually via ':MasonToolsInstall' etc....
        -- Default: nil
        debounce_hours = 5, -- at least 5 hours between attempts to install/update
      }
    end,
  },
}

-- https://github.com/neovim/nvim-lspconfig
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
    { 'folke/neodev.nvim', opts = {
      library = { plugins = { 'neotest' }, types = true },
    } },
  },
  config = function()
    local lspconfig = require 'lspconfig'
    local mason_lspconfig = require 'mason-lspconfig'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'
    local keymap = vim.keymap

    -- This will be executed everytime a LSP is attached to a buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(env)
        -- :help nvim.lsp.*
        local opts = { buffer = env.buf, silent = true }

        opts.desc = 'Show LSP references'
        keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)

        opts.desc = 'Go to declaration'
        keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

        opts.desc = 'Show LSP definitions'
        keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)

        opts.desc = 'Show LSP type definitions'
        keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

        opts.desc = 'See available code actions'
        keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

        opts.desc = 'Smart rename'
        keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

        opts.desc = 'Show buffer diagnostic'
        keymap.set('n', 'D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

        opts.desc = 'Show line diagnostics'
        keymap.set('n', 'd', vim.diagnostic.open_float, opts)

        opts.desc = 'Go to Previous diagnostic'
        keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

        opts.desc = 'Go to Next diagnostic'
        keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

        opts.desc = 'Show documentation'
        keymap.set('n', 'K', vim.lsp.buf.hover, opts)

        opts.desc = 'Restart LSP'
        keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts)
      end,
    })

    -- enable autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    -- default handlers for installed servers
    -- here, by catching the server_name, individual configurations can be set.
    mason_lspconfig.setup_handlers {
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
        }
      end,
      -- here, by catching the server_name, individual configurations can be set.
      -- and disable the default handler for the server.
      ['lua_ls'] = function()
        lspconfig['lua_ls'].setup {
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        }
      end,
      ['gopls'] = function()
        lspconfig['gopls'].setup {
          capabilities = capabilities,
          filetypes = { 'go', 'gomod', 'gowork', 'gotmpl', 'templ' },
          -- root_dir = util.root_pattern('go.work', 'go.mod', '.git')
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              codelenses = {
                generate = true,
                gc_details = true,
                tidy = true,
              },
              analyses = { -- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
                unusedparams = true,
                httpresponse = true,
                nonewvars = true,
                noresultvalues = true,
                printf = true,
                simplifyrange = true,
                simplifyslice = true,
                structtag = true,
                tests = true, -- https://pkg.go.dev/golang.org/x/tools/go/analysis/passes/tests
                staticcheck = true,
              },
              gofumpt = true,
            },
          },
        }
      end,
      ['denols'] = function()
        lspconfig['denols'].setup {
          capabilities = capabilities,
          filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
          -- root_dir = util.root_pattern('go.work', 'go.mod', '.git')
          settings = {
            deno = {
              enable = true,
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
      end,
      -- ["svelte"] = function()
      --  lspconfig["svelte"].setup({
      --    capabilities = capabilities,
      --    filetypes = {}, -- table of filetypes that this server will be attached too.
      --    on_attach = function(client, bufnr)
      --      vim.api.nvim_create_autocmd("BufWritePost", {
      --        pattern = { "*.js", "*.ts" },
      --        callback = function(ctx)
      --          client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
      --        end,
      --      })
      --    end,
      --  })
      -- end,
    }
  end,
  vim.filetype.add { extension = { templ = 'templ' } },
}

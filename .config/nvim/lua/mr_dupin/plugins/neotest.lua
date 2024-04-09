-- TODO: Improve this config
-- https://github.com/nvim-neotest/neotest
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-go',
  },
  config = function()
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)
    require('neotest').setup {
      log_level = vim.log.levels.INFO,
      highlights = {},
      summary = {
        expand_errors = true,
        animated = false,
        follow = false,
        enabled = true,
        border = {},
        title = 'Neotest Summary',
        position = 'top',
        show_all = true,
      },
      adapters = {
        require 'neotest-go' {
          experimental = {
            test_table = true,
          },
          args = { '-count=1', '-timeout=60s' },
        },
      },
    }
  end,
}

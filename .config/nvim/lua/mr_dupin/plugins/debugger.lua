-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/rcarriga/nvim-dap-ui
return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap, dapui = require 'dap', require 'dapui'
    local keymap = vim.keymap

    require('dap-go').setup()
    require('dapui').setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    keymap.set('n', '<leader>dc', dap.continue, { desc = 'DAP Continue' })
  end,
}

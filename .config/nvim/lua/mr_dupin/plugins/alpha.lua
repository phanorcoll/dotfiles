-- https://github.com/goolord/alpha-nvim
return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    dashboard.section.header.val = {
      '██╗██████╗  ██████╗ ███╗   ██╗███████╗',
      '██║██╔══██╗██╔═══██╗████╗  ██║██╔════╝',
      '██║██║  ██║██║   ██║██╔██╗ ██║█████╗  ',
      '╚═╝██║  ██║██║   ██║██║╚██╗██║██╔══╝  ',
      '██╗██████╔╝╚██████╔╝██║ ╚████║███████╗',
      '╚═╝╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝',
    }

    dashboard.section.buttons.val = {
      dashboard.button('e', '󰈔  New File', '<cmd>ene<CR>'),
      dashboard.button('SPC ee', '  Toggle file explorer', '<cmd>NvimTreeToggle<CR>'),
      dashboard.button('SPC ft', '  Find TODOs ', '<cmd>TodoTelescope<CR>'),
      dashboard.button('q', '󰛉  Close Neovim ', '<cmd>qa<CR>'),
    }

    alpha.setup(dashboard.opts)
    vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
  end,
}

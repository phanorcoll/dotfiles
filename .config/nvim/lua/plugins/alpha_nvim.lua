-- url: https://github.com/goolord/alpha-nvim
-- desc: A highly configurable dashboard for neovim built using alpha.nvim
return {
  'goolord/alpha-nvim',
  event = 'BufWinEnter',
  config = function()
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
      dashboard.button('e', '󰈔  New Buffer', '<cmd>ene<CR>'),
      dashboard.button('SPC ff', '  Find files', '<cmd>Telescope find_files<CR>'),
      dashboard.button('SPC ft', '  Find TODOs ', '<cmd>TodoTelescope<CR>'),
      dashboard.button('q', '󰛉  Close Neovim ', '<cmd>qa<CR>'),
    }

    require('alpha').setup(dashboard.opts)
    vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
  end,
}

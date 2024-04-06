-- https://github.com/rmagatti/auto-session
-- TODO: Tweak config
return {
  'rmagatti/auto-session',
  config = function()
    local auto_session = require 'auto-session'

    auto_session.setup {
      log_level = 'error',
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    }

    local keymap = vim.keymap
    keymap.set('n', '<leader>wr', '<cmd>SessionRestore<CR>', { desc = 'Restore session for cwd' })
    keymap.set('n', '<leader>ws', '<cmd>SessionSave<CR>', { desc = 'Save session' })
    vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
  end,
}

-- url: https://github.com/NeogitOrg/neogit
-- desc: Neogit is a magit like git client for neovim
return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only one of these is needed.
    'ibhagwan/fzf-lua', -- optional
  },
  config = function()
    require('neogit').setup {
      disable_signs = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      disable_builtin_notifications = false,
      auto_refresh = true,
      graph_style = 'unicode',
      commit_popup = {
        kind = 'split',
      },
      integrations = {
        diffview = true,
      },
    }
    local keymap = vim.keymap
    keymap.set('n', '<leader>gs', ':Neogit kind=floating<CR>', { desc = 'Open Neogit Floating window', silent = true, noremap = true })
    keymap.set('n', '<leader>gn', ':Neogit<CR>', { desc = 'Open Neogit' })
    keymap.set('n', '<leader>gc', ':Neogit commit<CR>', { desc = 'Create commit', silent = true, noremap = true })
    keymap.set('n', '<leader>gp', ':Neogit pull<CR>', { desc = 'Pull changes to branch', silent = true, noremap = true })
    keymap.set('n', '<leader>gP', ':Neogit push<CR>', { desc = 'Push changes to branch', silent = true, noremap = true })
  end,
}

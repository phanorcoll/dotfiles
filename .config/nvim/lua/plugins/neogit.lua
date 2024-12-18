-- url: https://github.com/NeogitOrg/neogit
-- desc: Neogit is a magit like git client for neovim
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua",              -- optional
    "echasnovski/mini.pick",         -- optional
  },
  config = function()
    require("neogit").setup {
      disable_signs = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      disable_builtin_notifications = false,
      auto_refresh = true,
      graph_style = "unicode",
      commit_popup = {
        kind = "split",
      },
      integrations = {
        diffview = true,
      },
    }
    local keymap = vim.keymap
    local neogit = require('neogit')
    keymap.set('n', '<leader>gn', function()
      neogit.open()
    end, { desc = 'Open Neogit' })
  end
}

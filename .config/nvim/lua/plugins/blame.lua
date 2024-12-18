-- url: https://github.com/FabijanZulj/blame.nvim
-- desc: Git Blame plugin for neovim
vim.keymap.set('n', '<leader>gB', ':BlameToggle<CR>')
return {
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require('blame').setup {}
    end,
    opts = {
      blame_options = { '-w' },
    },
  },
}

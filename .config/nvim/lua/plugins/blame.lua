vim.keymap.set('n', '<leader>gb', ':BlameToggle<CR>')
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
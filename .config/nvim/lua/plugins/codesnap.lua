-- url: https://github.com/mistricky/codesnap.nvim
-- desc: A neovim plugin to create code snapshots with ease.
return {
  'mistricky/codesnap.nvim',
  build = 'make build_generator',
  keys = {
    { '<leader>cc', '<cmd>CodeSnap<cr>', mode = 'x', desc = 'Save selected code snapshot into clipboard' },
    { '<leader>cs', '<cmd>CodeSnapSave<cr>', mode = 'x', desc = 'Save selected code snapshot in ~/Pictures' },
    { '<leader>ch', '<cmd>CodeSnapSaveHighlight<cr>', mode = 'x', desc = 'Save selected code snapshot in ~/Pictures' },
    { '<leader>ca', '<cmd>CodeSnapASCIIcr>', mode = 'x', desc = 'Save selected code in ASCII formar' },
  },
  opts = {
    code_font_family = 'CaskaydiaCove Nerd Font',
    bg_theme = 'grape',
    watermark = 'Phanor Coll',
  },
}

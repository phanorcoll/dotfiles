-- url: https://github.com/olacin/telescope-gitmoji.nvim
-- desc: Telescope extension to list gitmojis
return {
  'olacin/telescope-gitmoji.nvim',
  config = function()
    require('telescope').load_extension 'gitmoji'
  end,
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
}

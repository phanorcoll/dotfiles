-- https://github.com/folke/neodev.nvim
return {
  'folke/neodev.nvim',
  opts = {},
  configure = function()
    require('neodev').setup {
      library = { plugins = { 'neotest' }, types = true },
    }
  end,
}

-- url: https://github.com/uloco/bluloco.nvim
-- desc: A fancy and sophisticated designer neovim theme built with lush.nvim. It features a much more comprehensive usage of syntax scopes and color consistency, with due regards to aesthetics, contrast and readability.
return {
  'uloco/bluloco.nvim',
  lazy = false,
  priority = 1000,
  dependencies = { 'rktjmp/lush.nvim' },
  config = function()
    -- your optional config goes here, see below.
    require("bluloco").setup({
      style       = "dark", -- "auto" | "dark" | "light"
      transparent = true,
      italics     = true,
      terminal    = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
      guicursor   = true,
    })
    vim.cmd('colorscheme bluloco')
  end,
}

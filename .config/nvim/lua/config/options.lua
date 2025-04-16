local opt = vim.opt

opt.nu = true -- enable line numbers
opt.relativenumber = true -- relative line numbers
opt.clipboard:append 'unnamedplus' --clipboard
opt.termguicolors = true -- enable true color support

opt.undodir = os.getenv 'HOME' .. '/.vim/undodir' -- set directory where undo files are stored
opt.undofile = true -- save undo history to a file

vim.scriptencoding = 'utf-8' -- set the encoding of the current script file to UTF-8
opt.encoding = 'utf-8' -- set the encoding of the current buffer to UTF-8
opt.fileencoding = 'utf-8' -- set the encoding of the current file to UTF-8

-- dont show the mode since its already in the status bar
opt.showmode = false

-- tabs & indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true
opt.autoindent = true
opt.hlsearch = true
opt.wrap = false
opt.backspace = { 'indent', 'eol', 'start' }
opt.modifiable = true
opt.breakindent = true -- Enable break indent

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neowill display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
opt.confirm = true

--- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- remove trailing whitespace from all lines before saving a file)
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = CleanOnSave,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

-- vim.diagnostic.config {
--   signs = {
--     text = {
--       [vim.diagnostic.severity.ERROR] = '✘',
--       [vim.diagnostic.severity.WARN] = '▲',
--       [vim.diagnostic.severity.HINT] = '⚑',
--       [vim.diagnostic.severity.INFO] = '»',
--     },
--   },
-- }

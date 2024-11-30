local opt = vim.opt
opt.nu = true -- enable line numbers
opt.relativenumber = true -- relative line numbers
opt.clipboard:append 'unnamedplus' --clipboard
opt.termguicolors = true -- enable true color support

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = false
opt.backspace = 'indent,eol,start'

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true

-- window splitting
opt.splitright = true
opt.splitbelow = true

opt.list = true -- show tab characters and trailing whitespace

opt.swapfile = false -- do not use a swap file for the buffer
opt.backup = false -- do not keep a backup file
opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- set directory where undo files are stored
opt.undofile = true -- save undo history to a file

opt.signcolumn = "yes" -- always show the sign column, to avoid text shifting when signs are displayed
opt.updatetime = 50 -- Time in milliseconds to wait before triggering the plugin events after a change

------- functions

local CleanOnSave = vim.api.nvim_create_augroup('CleanOnSave', {})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  group = CleanOnSave,
  pattern = "*",
  command = [[%s/\s\+$//e]],
}) -- remove trailing whitespace from all lines before saving a file)

local HighlightYank = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = HighlightYank,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 400,
        })
    end,
}) -- highlight yanked text using the 'IncSearch' highlight group for 40ms

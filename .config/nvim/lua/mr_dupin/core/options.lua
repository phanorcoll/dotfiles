vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- set termguicolors and visuals
opt.termguicolors = true
--opt.background = "none"
opt.signcolumn = "yes"
opt.relativenumber = true
opt.number = true

--clipboard
opt.clipboard:append("unnamedplus")

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = false
opt.backspace = "indent,eol,start"

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true

-- window splitting
opt.splitright = true
opt.splitbelow = true

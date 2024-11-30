local opt = vim.opt
opt.nu = true 			-- enable line numbers
opt.relativenumber = true 		-- relative line numbers
--opt.termguicolors = true
--clipboard
opt.clipboard:append 'unnamedplus'

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

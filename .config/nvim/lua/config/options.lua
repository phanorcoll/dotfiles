-------------------------------------------------------------------------------
-- OPTIONS
-- Documentation: :help options
-------------------------------------------------------------------------------
local opt = vim.opt

-- Line Numbers & Appearance
opt.number = true -- Show absolute line number
opt.relativenumber = true -- Show relative line number
opt.cursorline = true -- Highlight the text line of the cursor
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.signcolumn = "yes" -- Always show the sign column (gutter)
opt.colorcolumn = "100" -- Vertical ruler at column 100
opt.showmatch = true -- Highlight matching brackets
opt.conceallevel = 0 -- Do not hide markup text
opt.concealcursor = "" -- Do not hide cursorline in markup
opt.fillchars = { eob = " " } -- Hide the "~" on empty lines
opt.cursorcolumn = true -- Highlight the screen column of the cursor

-- Make the cursor column a subtle grey/dark color
-- Adjust 'bg' to fit your terminal's theme
vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#cccccc", ctermbg = 235 })

-- General Behavior
opt.mouse = "a" -- Enable mouse support
opt.clipboard:append("unnamedplus") -- Use system clipboard
opt.hidden = true -- Allow background buffers without saving
opt.errorbells = false -- Disable beep/flash on errors
opt.updatetime = 300 -- Faster completion and diagnostic updates
opt.timeoutlen = 500 -- Wait time for mapped sequences
opt.ttimeoutlen = 0 -- Wait time for key codes
opt.lazyredraw = true -- Do not redraw screen during macros
opt.encoding = "utf-8" -- Set internal string encoding
opt.iskeyword:append("-") -- Treat dash-separated words as a single unit

-- Text Formatting & Indentation
opt.wrap = false -- Disable line wrapping
opt.tabstop = 2 -- Number of spaces a <Tab> counts for
opt.shiftwidth = 2 -- Size of an indent
opt.softtabstop = 2 -- Number of spaces a <Tab> counts for while editing
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Insert indents automatically
opt.autoindent = true -- Copy indent from current line
opt.backspace = "indent,eol,start" -- Allow backspacing over everything

-- Search Settings
-- Documentation: :help pattern-searches
opt.ignorecase = true -- Case-insensitive search
opt.smartcase = true -- Case-sensitive if search contains uppercase
opt.hlsearch = true -- Highlight all matches of previous search
opt.incsearch = true -- Show search results as you type

-- Scrolling
opt.scrolloff = 10 -- Lines of context above/below cursor
opt.sidescrolloff = 10 -- Columns of context to left/right of cursor

-- Windows & Splits
opt.splitbelow = true -- New horizontal splits go below
opt.splitright = true -- New vertical splits go right

-- Command Line & UI
opt.cmdheight = 1 -- Height of the command line
opt.showmode = false -- Hide mode (e.g., -- INSERT --) as it's in statusline
opt.pumheight = 10 -- Max items in popup menu
opt.pumblend = 10 -- Transparency for popup menu
opt.winblend = 0 -- Transparency for floating windows
opt.wildmenu = true -- Command-line completion
opt.wildmode = "longest:full,full" -- Completion mode for wildmenu

-- File & Buffer Handling
opt.backup = false -- Do not create backup files
opt.writebackup = false -- Do not write to a backup file
opt.swapfile = false -- Do not use swap files
opt.autoread = true -- Reload files changed outside Nvim
opt.autowrite = false -- Do not auto-save on buffer switches
opt.path:append("**") -- Search subdirectories recursively

-- Performance & Limits
opt.synmaxcol = 300 -- Limit syntax highlighting to 300 columns
opt.redrawtime = 10000 -- Increase redraw tolerance
opt.maxmempattern = 20000 -- Increase memory for pattern matching

-- Improve diff display
-- linematch:60 enables an internal heuristic to better align changed lines
-- especially useful for large chunks of moved/modified code
opt.diffopt:append("linematch:60")

-- Cursor Styling
-- opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-------------------------------------------------------------------------------
-- UNDO CONFIGURATION
-- Documentation: :help undo-redo
-------------------------------------------------------------------------------
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

opt.undofile = true -- Enable persistent undo
opt.undodir = undodir -- Set the directory for undo files

-------------------------------------------------------------------------------
-- FOLDING (Treesitter Based)
-- Documentation: :help treesitter
-------------------------------------------------------------------------------
opt.foldmethod = "expr" -- Use expressions for folding
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use Treesitter for folding
opt.foldlevel = 99 -- Start with all folds open

-------------------------------------------------------------------------------
-- set the default border for all floating windows
-- Documentation: :help winborder
-------------------------------------------------------------------------------
vim.o.winborder = "rounded"

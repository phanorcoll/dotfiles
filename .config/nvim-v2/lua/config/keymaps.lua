-- exit insert mode
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- save file
vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "Saves file" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>dn", function()
	vim.diagnostic.goto_next({ wrap = true })
end, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>dl", function()
	vim.diagnostic.open_float()
end, { desc = "Open line diagnostic" })

-- window splitting
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window verrtically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- resize window
vim.keymap.set("n", "<C-Left>", "<C-w><", {})
vim.keymap.set("n", "<C-Right>", "<C-w>>", {})
vim.keymap.set("n", "<C-Up>", "<C-w>+", {})
vim.keymap.set("n", "<C-Down>", "<C-w>-", {})

-- yank line to clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

-- move a blocks of text up/down with K/J in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

-- Tabs to move through Buffers
vim.keymap.set("n", "<TAB>", "<CMD>bnext<CR>")
vim.keymap.set("n", "<S-TAB>", "<CMD>bprevious<CR>")

-- close current buffer
vim.keymap.set("n", "<leader>cb", "<CMD>bd<CR>", { desc = "Close current buffer", silent = true })

-- format on save with conform.nvim
vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "Format current file" })

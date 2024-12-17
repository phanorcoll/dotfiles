local keymap = vim.keymap

keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode' })
keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- window splitting
keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window verrtically' })
keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make split equal size' })
keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' })

-- Pane navigation
keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to preview pane' })
keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to next pane' })
keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom pane' })
keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top pane' })

-- resize window
keymap.set('n', '<C-Left>', '<C-w><', {})
keymap.set('n', '<C-Right>', '<C-w>>', {})
keymap.set('n', '<C-Up>', '<C-w>+', {})
keymap.set('n', '<C-Down>', '<C-w>-', {})

-- Tabs to move through Buffers
keymap.set('n', '<TAB>', '<CMD>bnext<CR>')
keymap.set('n', '<S-TAB>', '<CMD>bprevious<CR>')

-- yank to clipboard
keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- yank line to clipboard
keymap.set("n", "<leader>Y", [["+Y]])

-- move a blocks of text up/down with K/J in visual mode
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

-- save, quit
keymap.set("n", "<leader>w", ":w<cr>")
keymap.set("n", "<leader>c", ":q<cr>")

-- diagnostics
keymap.set("n", "<leader>dn", function()
  vim.diagnostic.goto_next({ wrap = true })
end, { desc = "Go to next diagnostic" })

-- Terminal
keymap.set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 10)
end, { desc = "Open terminal" })

keymap.set("t", "<leader>q", "<C-\\><C-n>:q!<CR>", { desc = "Close terminal" })

keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

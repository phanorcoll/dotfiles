vim.g.mapleader = ' '
local keymap = vim.keymap

keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode' })
keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' }) 

-- window splitting
keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window verrtically' })
keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make split equal size' })
keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' })

-- Pane navigation
keymap.set('n', '<leader>hh', '<C-w>h', { desc = 'Move to preview pane' })
keymap.set('n', '<leader>ll', '<C-w>l', { desc = 'Move to next pane' })
keymap.set('n', '<leader>jj', '<C-w>j', { desc = 'Move to bottom pane' })
keymap.set('n', '<leader>kk', '<C-w>k', { desc = 'Move to top pane' })

-- resize window
keymap.set('n', '<C-Left>', '<C-w><', {})
keymap.set('n', '<C-Right>', '<C-w>>', {})
keymap.set('n', '<C-Up>', '<C-w>+', {})
keymap.set('n', '<C-Down>', '<C-w>-', {})

-- Tabs to move through Buffers
keymap.set('n', '<TAB>', '<CMD>bnext<CR>')
keymap.set('n', '<S-TAB>', '<CMD>bprevious<CR>')


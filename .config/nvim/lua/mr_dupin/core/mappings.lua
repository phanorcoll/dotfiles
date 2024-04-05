vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("i","jk","<ESC>",{ desc = "Exit insert mode"})
keymap.set("n","<leader>nh",":nohl<CR>",{ desc = "Clear search highlights"})

-- window splitting
keymap.set("n","<leader>sv","<C-w>v",{ desc = "Split window verrtically"})
keymap.set("n","<leader>sh","<C-w>s",{ desc = "Split window horizontally"})
keymap.set("n","<leader>se","<C-w>=",{ desc = "Make split equal size"})
keymap.set("n","<leader>sx","<cmd>close<CR>",{ desc = "Close current split"})

-- tab management WIP: This might be removed later
keymap.set("n","<leader>to","<cmd>tabnew<CR>",{ desc = "Open Tab"})
keymap.set("n","<leader>tx","<cmd>tabclose<CR>",{ desc = "Close Tab"})
keymap.set("n","<leader>tn","<cmd>tabn<CR>",{ desc = "Go to next tab"})
keymap.set("n","<leader>tp","<cmd>tabp<CR>",{ desc = "Go to previous tab"})
keymap.set("n","<leader>tf","<cmd>tabnew %<CR>",{ desc = "Open current buffer in new tab"})

vim.pack.add({ "https://github.com/folke/todo-comments.nvim", "https://github.com/nvim-lua/plenary.nvim" })
require("todo-comments").setup()

vim.keymap.set("n", "<leader>tf",":TodoFzfLua<CR>", { desc = "FZF Todos" })
vim.keymap.set("n", "<leader>tq",":TodoQuickFix<CR>", { desc = "Quickfix Todos" })

-- url: https://github.com/folke/todo-comments.nvim
-- desc: A todo comment plugin for neovim written in lua
-- TODO: something
return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		{ "<leader>tf", ":TodoFzfLua<CR>", desc = "find TODOs" },
		{ "<leader>tq", ":TodoQuickFix<CR>", desc = "Quickfix list to show all todos" },
		{ "<leader>tt", ":Trouble todo<CR>", desc = "List all project todos in trouble" },
	},
}

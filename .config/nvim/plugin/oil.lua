vim.pack.add({ "https://github.com/stevearc/oil.nvim", "https://github.com/refractalize/oil-git-status.nvim" })
require("oil").setup({
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},
	win_options = {
		signcolumn = "yes:2",
	},
})

require("oil-git-status").setup({})

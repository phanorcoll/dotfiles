vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/leoluz/nvim-dap-go",
})


require("dap-go").setup({
	delve = {
		path = "dlv",
		initialize_timeout_sec = 20,
	},
	-- optional: use a dedicated debug window layout later
})

vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
	formatters = {
		golines = {
			prepend_args = { "--max-len=100" },
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofumpt", "golines" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		markdown = { "prettier" },
	},
})

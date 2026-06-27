vim.pack.add({
	"https://www.github.com/mason-org/mason.nvim",
	"https://www.github.com/mason-org/mason-lspconfig.nvim",
	"https://www.github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
    --language servers
    "lua_ls",
		"bashls",
		"cssls",
		"dockerls",
		"docker_compose_language_service",
		"gopls",
		"html",
		"jsonls",
		-- "ts_ls",
    "vtsls", -- <-- for typescript
		"templ",
		"tailwindcss",
		"terraformls",
		--formatters
		"stylua",
    "prettier",
		"gofumpt",
		"goimports",
		"golines",
		--linters
		"revive", -- <--  for Go
		"eslint_d", -- <-- for javascript/typescript
		"jsonlint", -- <-- for json
		"tflint", -- <-- for terraform
		"shellcheck", -- <-- for shell scripts
	},
})

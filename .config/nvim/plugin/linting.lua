vim.pack.add({
	"https://github.com/mfussenegger/nvim-lint",
})

local lint = require("lint")
lint.linters_by_ft = {
	json = { "jsonlint" },
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	go = { "revive" },
	terraform = { "tflint" },
	bash = { "sheljcheck" },
	lua = { "selene" }
}
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
--NOTE: this is not being triggered in InsertLeave, only when saving and loaidng a buffer
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

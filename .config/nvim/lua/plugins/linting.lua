-- url: https://github.com/mfussenegger/nvim-lint
-- desc: An asynchronous linter plugin for Neovim (>= 0.9.5) complementary to the built-in Language Server Protocol support.
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			json = { "jsonlint" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			go = { "revive" },
			terraform = { "tflint" },
		}
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>li", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}

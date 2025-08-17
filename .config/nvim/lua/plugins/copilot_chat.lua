-- url: https://github.com/CopilotC-Nvim/CopilotChat.nvim
-- desc: CopilotChat.nvim is a Neovim plugin that brings GitHub Copilot Chat capabilities directly into your editor
return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
	},
	build = "make tiktoken",
	keys = {
		{ "<leader>cps", "<cmd>CopilotChat<cr>", mode = { "n", "v" }, desc = "CopilotChat - Open chat" },
		{
			"<leader>cpq",
			function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, {
						selection = require("CopilotChat.select").buffer,
					})
				end
			end,
			desc = "CopilotChat - Quick chat",
		},
		{
			"<leader>cpp",
			function()
				local input = vim.fn.input("Ask Perplexity: ")
				if input ~= "" then
					require("CopilotChat").ask(input, {
						agent = "perplexityai",
						selection = false,
					})
				end
			end,
			desc = "CopilotChat - Ask Perplexity",
		},
		{ "<leader>cpe", "<cmd>CopilotChatExplain<cr>", mode = "v", desc = "CopilotChat - Explain code" },
		{ "<leader>cpr", "<cmd>CopilotChatReview<cr>", mode = "v", desc = "CopilotChat - Review code" },
		{ "<leader>cpf", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "CopilotChat - Fix code issues" },
		{ "<leader>cpo", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "CopilotChat - Optimize code" },
		{ "<leader>cpd", "<cmd>CopilotChatDocs<cr>", mode = "v", desc = "CopilotChat - Generate docs" },
		{ "<leader>cpt", "<cmd>CopilotChatTests<cr>", mode = "v", desc = "CopilotChat - Generate tests" },
		{ "<leader>cpc", "<cmd>CopilotChatCommit<cr>", desc = "CopilotChat - Generate commit message" },
	},
	opts = {},
	config = function(_, _)
		vim.api.nvim_set_hl(0, "CopilotChatHeader", { fg = "#fefefe", bold = true })
		vim.api.nvim_set_hl(0, "CopilotChatSeparator", { fg = "#374151" })
		-- Auto-command to customize chat buffer behavior
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "copilot-*",
			callback = function()
				vim.opt_local.relativenumber = false
				vim.opt_local.number = false
				vim.opt_local.conceallevel = 0
			end,
		})
		require("fzf-lua").register_ui_select()
		require("CopilotChat").setup({
			-- See Configuration section for options
			headers = {
				user = "👤 code wizard ",
				assistant = "🤖 Copilot: ",
				tool = "🔧 Tool: ",
			},
			highlight_headers = true,
			error_header = "> [!ERROR] Error",
			separator = "━━",
			show_folds = false,
			model = "gemini-2.5-pro", -- AI model to use
			temperature = 0.1, -- Lower = focused, higher = creative
			window = {
				layout = "vertical", -- 'vertical', 'horizontal', 'float'
				width = 0.45, -- screen width
			},
			auto_insert_mode = false, -- Enter insert mode when opening
			prompts = {
				PRMessage = {
					prompt = [[
					generate a pull request message adhering to best practices for the title and body:

					**1. PR Title:**
					   - Be concise and informative (keep it under 50 characters).
					   - Start with a clear prefix indicating the area or type of change (e.g., `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `build:`, `ci:`, `perf:`, `chore:`).
					   - Clearly describe the main purpose of the changes.
					   - Example: `feat: Implement user authentication using JWT`

					**2. PR Body:**
					   - Provide a high-level summary of what the PR introduces.
					   - Explain the "why" behind the changes (the problem being solved or the goal being achieved).
					   - If applicable, include:
					     - Key changes and their impact.
					     - How the changes were implemented.
					     - Any important context or considerations for reviewers.
					     - Links to relevant issues or documentation.
					]],
					system_prompt = "You are an AI assistant specialized in generating well-formatted and informative pull request messages. Format as a gitcommit code block.",
					description = "Generate a pull request message for the current branch's commits.",
				},
				JSDoc = {
					prompt = [[
					Generate JSDoc/TSDoc comments for the following JavaScript/TypeScript function, adhering to best practices:

					- Clearly document all parameters, including their type and a concise description.
					- Document the return value, including its type and a description of what it represents.
					- If the function can throw errors, document the conditions under which it might do so using the `@throws` tag.
					- Provide a brief summary of the function's purpose at the beginning.

					```${function_code}```
					]],
					system_prompt = "You are an expert JavaScript and TypeScript developer who writes clear, accurate, and comprehensive JSDoc/TSDoc comments following best practices.",
					description = "Generate JSDoc/TSDoc comments for the currently selected JavaScript or TypeScript function.",
				},
			},
		})
	end,
}

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
		{ "<leader>cpe", "<cmd>CopilotChatExplain<cr>", mode = "v", desc = "CopilotChat - Explain code" },
		{ "<leader>cpr", "<cmd>CopilotChatReview<cr>", mode = "v", desc = "CopilotChat - Review code" },
		{ "<leader>cpf", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "CopilotChat - Fix code issues" },
		{ "<leader>cpo", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "CopilotChat - Optimize code" },
		{ "<leader>cpd", "<cmd>CopilotChatDocs<cr>", mode = "v", desc = "CopilotChat - Generate docs" },
		{ "<leader>cpt", "<cmd>CopilotChatTests<cr>", mode = "v", desc = "CopilotChat - Generate tests" },
		{ "<leader>cpc", "<cmd>CopilotChatCommit<cr>", desc = "CopilotChat - Generate commit message" },
	},
	opts = {},
	config = function(_, opts)
		require("fzf-lua").register_ui_select()
		require("CopilotChat").setup({
			-- See Configuration section for options
			use_ui_select = true,
			highlight_headers = false,
			question_header = "# 🧙 Wizard's Inquiry",
			answer_header = "# 🤖 Copilot Replies: ",
			error_header = "# 🚨 oops: ",
			separator = "  ",
			window = {
				layout = "float",
				col = vim.o.columns - 2,
				relative = "editor",
				width = math.floor(vim.o.columns * 0.4),
				height = math.floor(vim.o.lines * 0.8),
				border = "rounded",
				title = "💡 Code Whisperer",
				footer = "📜 Control what you can!!",
			},
		})
	end,
}

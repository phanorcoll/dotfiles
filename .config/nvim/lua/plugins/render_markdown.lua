-- url: https://github.com/MeanderingProgrammer/render-markdown.nvim
-- desc: Plugin to improve viewing Markdown files in Neovim
return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {},
	config = function()
		require("render-markdown").setup({
			completions = { blink = { enabled = true } },
			file_types = { "markdown", "copilot-chat" },
		})
	end,
}

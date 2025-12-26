-- url: https://github.com/iamcco/markdown-preview.nvim
-- desc: Preview Markdown in your modern browser with synchronised scrolling and flexible configuration..
return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	keys = {
		{ "<leader>mp", "<cmd>MarkdownPreview<cr>", mode = { "n", "v" }, desc = "Open MarkdownPreview" },
	},
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
}

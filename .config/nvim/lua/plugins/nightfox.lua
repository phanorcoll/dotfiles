-- url: https://github.com/EdenEast/nightfox.nvim
-- desc: A highly customizable theme for vim and neovim with support for lsp, treesitter and a variety of plugins.
return {
	"EdenEast/nightfox.nvim",
	config = function()
		require("nightfox").setup({
			options = {
				transparent = true,
				styles = {
					comments = "italic",
					keywords = "bold",
					functions = "italic,bold",
					variables = "italic",
					types = "italic",
				},
			},
			palettes = {},
			specs = {},
			highlights = {},
		})
		vim.cmd("colorscheme terafox")
	end,
}

-- url: https://githob.com/akinsho/bufferline.nvim
-- desc: Bufferline is a snazzy buffer line for Neovim
return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({})
	end,
}

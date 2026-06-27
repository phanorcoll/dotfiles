vim.pack.add({ "https://www.github.com/ibhagwan/fzf-lua" })
require("fzf-lua").setup({
	files = {
		previewer = "bat",
		git_icons = true,
	},
})
require("fzf-lua").register_ui_select()

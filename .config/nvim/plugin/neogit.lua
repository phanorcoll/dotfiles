vim.pack.add({
	"https://github.com/neogitorg/neogit",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/sindrets/diffview.nvim",
	"https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-tree/nvim-web-devicons"
})

local neogit = require("neogit")
neogit.setup({
	graph_style = "unicode",
	integrations = {
		diffview = true,
		fzf_lua = true,
	},
	diff_viewer = "diffview",
})

vim.keymap.set("n", "<leader>gn", function()
	neogit.open({ kind = "tab" })
end, { desc = "Open Neogit UI" })

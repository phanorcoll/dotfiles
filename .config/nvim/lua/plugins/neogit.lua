-- url: https://github.com/NeogitOrg/neogit
-- desc: Neogit is a magit like git client for neovim
return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed.
		"ibhagwan/fzf-lua", -- optional
	},
	keys = {
		{ "<leader>gn", ":Neogit<CR>", { desc = "Open Neogit" } },
	},
	config = function()
		require("neogit").setup({
			auto_refresh = true,
			graph_style = "unicode",
			integrations = {
				-- If enabled, use telescope for menu selection rather than vim.ui.select.
				-- Allows multi-select and some things that vim.ui.select doesn't.
				telescope = nil,
				-- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
				-- The diffview integration enables the diff popup.
				--
				-- Requires you to have `sindrets/diffview.nvim` installed.
				diffview = true,

				-- If enabled, uses fzf-lua for menu selection. If the telescope integration
				-- is also selected then telescope is used instead
				-- Requires you to have `ibhagwan/fzf-lua` installed.
				fzf_lua = true,

				-- If enabled, uses mini.pick for menu selection. If the telescope integration
				-- is also selected then telescope is used instead
				-- Requires you to have `echasnovski/mini.pick` installed.
				mini_pick = nil,
			},
		})
	end,
}

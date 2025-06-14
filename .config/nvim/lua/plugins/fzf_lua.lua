-- url: https://github.com/ibhagwan/fzf-lua
-- desc: Wrapper around fzf for neovim. Replaces Telescope for searching
return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		local config = require("fzf-lua.config")
		local actions = require("trouble.sources.fzf").actions
		config.defaults.actions.files["ctrl-t"] = actions.open
		require("fzf-lua").setup({
			-- Customize the window/popup layout
			fzf_colors = {
				true,
				bg = "-1",
			},
			files = {
				-- previewer = "bat",
				-- Custom fzf options
			},
			grep = {
				hidden = true, -- search hidden files
				no_ignore = true, -- search files that are ignored by .gitignore
			},
			winopts = {
				width = 0.80,

				-- FZF-Lua preview configuration
				preview = {
					layout = "vertical",
					vertical = "down:70%",
				},
				border = "rounded",
			},
		})
	end,
	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find Files in project directory",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Find by grepping in project directory",
		},
		{
			"<leader>fc",
			function()
				require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find in neovim configuration",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").helptags()
			end,
			desc = "[F]ind [H]elp",
		},
		{
			"<leader>fk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "[F]ind [K]eymaps",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").builtin()
			end,
			desc = "[F]ind [B]uiltin FZF",
		},
		{
			"<leader>fw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "[F]ind current [W]ord",
		},
		{
			"<leader>fW",
			function()
				require("fzf-lua").grep_cWORD()
			end,
			desc = "[F]ind current [W]ORD",
		},
		{
			"<leader>fd",
			function()
				require("fzf-lua").diagnostics_document()
			end,
			desc = "[F]ind [D]iagnostics",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").resume()
			end,
			desc = "[F]ind [R]esume",
		},
		{
			"<leader>fo",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "[F]ind [O]ld Files",
		},
		{
			"<leader><leader>",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Find existing buffers",
		},
		{
			"<leader>/",
			function()
				require("fzf-lua").lgrep_curbuf()
			end,
			desc = "[/] Live grep the current buffer",
		},
		{
			"<leader>gf",
			function()
				require("fzf-lua").git_files()
			end,
			desc = "[/] Find git files",
		},
		{
			"<leader>gb",
			function()
				require("fzf-lua").git_blame()
			end,
			desc = "[/] Find git blames",
		},
		{
			"<leader>gc",
			function()
				require("fzf-lua").git_commits()
			end,
			desc = "[/] Find git commits logs",
		},
		{
			"<leader>gl",
			function()
				require("fzf-lua").git_bcommits()
			end,
			desc = "[/] Find git commit logs on buffer",
		},
		{
			"<leader>gr",
			function()
				require("fzf-lua").git_branches()
			end,
			desc = "[/] Find git branches",
		},
	},
}

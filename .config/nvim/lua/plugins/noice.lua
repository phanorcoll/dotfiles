-- url: https://github.com/folke/noice.nvim
-- desc: A noice message system for Neovim
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- add any options here
		cmdline = {
			view = "cmdline_popup",
			opts = {
				position = {
					row = "50%",
					col = "50%",
				},
				size = {
					height = "auto",
				},
			},
		},
		lsp = {
			progress = {
				enabled = false,
			},
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = false, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
	},
	keys = {
		{
			"<leader>nh",
			"<CMD>NoiceHistory<CR>",
			desc = "View Noice history",
		},
		{
			"<leader>ne",
			"<CMD>NoiceErrors<CR>",
			desc = "View Noice errors",
		},
		{
			"<leader>nl",
			"<CMD>NoiceLast<CR>",
			desc = "View last message",
		},
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		{
			"rcarriga/nvim-notify",
			opts = {
				timeout = 1000, -- 1 second
				stages = "fade", -- fade animation
				-- other nvim-notify specific options...
			},
		},
	},
}

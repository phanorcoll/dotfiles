-- url: https://cmp.saghen.dev/
-- desc: blink.cmp is a completion plugin with support for LSPs and external sources that updates on every keystroke with minimal overhead.
return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		"moyiz/blink-emoji.nvim",
		"fang2hou/blink-copilot",
	},

	-- use a release tag to download pre-built binaries
	version = "1.*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = { preset = "super-tab" },

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			documentation = { auto_show = true },
			menu = {
				border = "rounded",
				draw = {
					columns = {
						{
							"kind_icon",
						},
						{ "label" },
						{
							"kind",
						},
					},
				},
			},
			ghost_text = {
				enabled = true,
			},
		},

		signature = { enabled = true },
		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "copilot", "lsp", "path", "snippets", "buffer", "emoji" },
			per_filetype = {
				sql = { "snippets", "dadbod", "buffer" },
				["copilot-chat"] = {}, -- Disable all providers for copilot-chat
			},
			providers = {
				emoji = {
					module = "blink-emoji",
					name = "Emoji",
					score_offset = 15, -- Tune by preference
					opts = { insert = true }, -- Insert emoji (default) or complete its name
					should_show_items = function()
						return vim.tbl_contains(
							-- Enable emoji completion only for git commits and markdown.
							-- By default, enabled for all file-types.
							{ "gitcommit", "markdown" },
							vim.o.filetype
						)
					end,
				},
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
				},
				dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			},
		},
		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}

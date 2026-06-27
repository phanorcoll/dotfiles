vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.1" },
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/zbirenbaum/copilot.lua", -- The AI engine
	"https://github.com/giuxtaposition/blink-cmp-copilot", -- The blink source
})

local function get_mini_icon(ctx)
	if ctx.source_name == "Path" then
		local is_unknown_type =
			vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
		local mini_icon, mini_hl, _ = require("mini.icons").get(
			is_unknown_type and "os" or ctx.item.data.type,
			is_unknown_type and "" or ctx.label
		)
		if mini_icon then
			return mini_icon, mini_hl
		end
	end

	-- Check if it's a snippet specifically
	if ctx.kind == "Snippet" then
		return require("mini.icons").get("lsp", "snippet")
	end

	local mini_icon, mini_hl = require("mini.icons").get("lsp", ctx.kind:lower())
	return mini_icon, mini_hl
end

-- Initialize Copilot first
require("copilot").setup({
	-- It's highly recommended to disable the native ghost text/panel
	-- so they don't fight with blink.cmp's UI
	suggestion = { enabled = false },
	panel = { enabled = false },
})

require("blink.cmp").setup({
	fuzzy = { implementation = "prefer_rust" },
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		ghost_text = {
			enabled = true,
		},
		menu = {
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
							local kind_icon, kind_hl = get_mini_icon(ctx)
							return kind_icon
						end,
						-- (optional) use highlights from mini.icons
						highlight = function(ctx)
							local _, hl = get_mini_icon(ctx)
							return hl
						end,
					},
					kind = {
						-- (optional) use highlights from mini.icons
						highlight = function(ctx)
							local _, hl = get_mini_icon(ctx)
							return hl
						end,
					},
				},
			},
			direction_priority = function()
				local ctx = require("blink.cmp").get_context()
				local item = require("blink.cmp").get_selected_item()
				if ctx == nil or item == nil then
					return { "s", "n" }
				end

				local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
				local is_multi_line = item_text:find("\n") ~= nil

				-- after showing the menu upwards, we want to maintain that direction
				-- until we re-open the menu, so store the context id in a global variable
				if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
					vim.g.blink_cmp_upwards_ctx_id = ctx.id
					return { "n", "s" }
				end
				return { "s", "n" }
			end,
		},
	},

	keymap = {
		preset = "default",
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
	},
	-- Ensure LSP is enabled as a source
	sources = {
		-- Add 'copilot' to your default list
		default = { "lsp", "copilot", "snippets", "buffer", "path" },
		providers = {
			copilot = {
				name = "copilot",
				module = "blink-cmp-copilot",
				score_offset = 100, -- Keep AI suggestions high
				async = true,
				transform_items = function(_, items)
					local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
					local kind_idx = #CompletionItemKind + 1
					CompletionItemKind[kind_idx] = "Copilot"
					for _, item in ipairs(items) do
						item.kind = kind_idx
					end
					return items
				end,
			},
		},
	},
})

vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })
require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
local notify = require("mini.notify")
notify.setup({
	-- Terminal window options
	window = {
		-- Floating window config
		config = {
			border = "rounded", -- Options: 'single', 'double', 'shadow', 'rounded'
			anchor = "NE", -- North-East: anchors to the top-right corner
			col = vim.o.columns,
			row = 0,
		},
		-- Maximum width of the window
		max_width = 40,
		-- Minimum width of the window
		winblend = 10, -- Transparency (0-100), 10 provides a subtle glass effect
	},

	-- Period (in ms) of automation tick
	timer = {
		-- Default time for message to stay visible
		duration = 5000,
	},
})

-- Optional: Redirect vim.notify to mini.notify
vim.notify = require("mini.notify").make_notify()

require("mini.icons").setup({
	lsp = {
		["function"] = { glyph = "󰊕", hl = "MiniIconsAzure" },
		["method"] = { glyph = "󰊕", hl = "MiniIconsAzure" },
		["variable"] = { glyph = "󰆦", hl = "MiniIconsGold" },
		["interface"] = { glyph = "󰭦", hl = "MiniIconsCyan" },
		["struct"] = { glyph = "󰙅", hl = "MiniIconsCyan" },
		["module"] = { glyph = "󰏗", hl = "MiniIconsRed" },
		["property"] = { glyph = "󰜢", hl = "MiniIconsGold" },
		["field"] = { glyph = "󰜢", hl = "MiniIconsGold" },
		["typeparameter"] = { glyph = "󰅲", hl = "MiniIconsPurple" },
		["constant"] = { glyph = "󰏿", hl = "MiniIconsOrange" },

		copilot = { glyph = "", hl = "CmpItemKindCopilot" },
		class = { glyph = "󰠱", hl = "MiniIconsYellow" },
		constructor = { glyph = "", hl = "MiniIconsAzure" },
		enum = { glyph = "", hl = "MiniIconsGreen" },
		enummember = { glyph = "", hl = "MiniIconsGreen" },
		event = { glyph = "", hl = "MiniIconsYellow" },
		folder = { glyph = "󰉋", hl = "MiniIconsBlue" },
		file = { glyph = "󰈔", hl = "MiniIconsGrey" },
		keyword = { glyph = "󰌋", hl = "MiniIconsPurple" },
		operator = { glyph = "󰆕", hl = "MiniIconsGrey" },
		snippet = { glyph = "󰘦", hl = "MiniIconsRed" },
		text = { glyph = "󰉿", hl = "MiniIconsGrey" },
		unit = { glyph = "󰑭", hl = "MiniIconsRed" },
		value = { glyph = "󰎟", hl = "MiniIconsOrange" },
	},
	default = {
		snippet = { glyph = "󰘦", hl = "MiniIconsRed" },
	},
})
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" }) -- Greenish

local minibr = require("mini.bufremove")

-- 1. Unshow in current window: Replace buffer in current window with another
-- Useful for "hiding" a buffer from view without closing it.
vim.keymap.set("n", "<leader>bu", function()
	minibr.unshow_in_window(0)
end, { desc = "Buffer: Unshow in window" })

-- 2. Wipeout: Completely remove buffer from memory (including variables/options)
-- This is more "destructive" than delete.
vim.keymap.set("n", "<leader>bw", function()
	minibr.wipeout(0, false) -- Change false to true to force wipeout
end, { desc = "Buffer: Wipeout" })

-- 3. Unshow: Remove buffer from ALL windows where it is displayed
vim.keymap.set("n", "<leader>bA", function()
	minibr.unshow(0)
end, { desc = "Buffer: Unshow in all windows" })

-- Delete current buffer while keeping window layout
vim.keymap.set("n", "<leader>bd", function()
	local bd = minibr.delete
	if vim.bo.modified then
		local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
		if choice == 1 then -- Yes
			vim.cmd.write()
			bd(0, false)
		elseif choice == 2 then -- No
			bd(0, true)
		end
	else
		bd(0, false)
	end
end, { desc = "Delete Buffer (Smart)" })

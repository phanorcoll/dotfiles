-------------------------------------------------------------------------------
-- 4. KEYMAPS & AUTOCOMMANDS
-------------------------------------------------------------------------------
local map = vim.keymap.set
-- Better movement in wrapped text
-- Uses 'gj'/'gk' unless a count is provided (e.g., 5j)
map("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })

map("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Search & Highlights
map("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Keep cursor centered during search navigation and jumping
-- zz: centers screen, zv: opens folds
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Register Management (The "Void" Register)
-- Documentation: :help quote_
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking (overwrite)" })
map({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

-- Window Navigation (Simple Ctrl + direction)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window Management & Resizing
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Line/Selection Manipulation (Alt + j/k)
-- Moves lines up/down and maintains indentation
-- map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
-- map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
-- map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Visual Indentation
-- gv: re-selects the last visual selection area
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Quick escape
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Save file
map("n", "<leader>w", ":w<cr>", { desc = "Save current buffer" })

-- Buffer Navigation
-- Documentation: :help :bnext
map("n", "<leader>bn", ":bnext<CR>", { desc = "Switch to next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Switch to previous buffer" })

-- close current buffer
map("n", "<leader>cb", "<CMD>bd<CR>", { desc = "Close current buffer" })

-- restart neovim
map("n", "<leader>rs", "<CMD>restart<CR>", { desc = "Restarts Neovim" })

-- Copy and display the full path of the current file
-- %:p expands to the full absolute path of the current buffer
map("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p") -- Get absolute path
	vim.fn.setreg("+", path) -- Copy path to system clipboard (+)
	print("Copied: " .. path) -- Confirm via echo area
end, { desc = "Copy and print full file path" })

-- oil.nvim
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- FZF-Lua Fuzzy Finder Mappings
-- Fast navigation using the RPC-capable FZF-Lua plugin
map("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "FZF Files" })
map("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })
map("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "FZF Buffers" })
map("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })
map("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document({
		previewer = "bat", -- Uses fzf-lua's high-performance Lua previewer
		winopts = {
			title = " Dia",
			preview = {
				layout = "vertical", -- Better for side-by-side code comparison
				vertical = "down:70%",
			},
		},
	})
end, { desc = "FZF Diagnostics Document" })
map("n", "<leader>fX", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })

-- Diagnostic Mappings

-- Copy line diagnostics to clipboard
-- Accesses the diagnostic-api to extract message strings
map("n", "<leader>lc", function()
	-- Get all diagnostics for the current line
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
	if #diagnostics == 0 then
		return
	end

	-- Extract messages and join them (in case of multiple errors on one line)
	local messages = {}
	for _, d in ipairs(diagnostics) do
		table.insert(messages, d.message)
	end

	local full_message = table.concat(messages, "\n")
	vim.fn.setreg("+", full_message) -- Copy to system clipboard
	print("Copied diagnostic: " .. #diagnostics .. " issue(s)")
end, { desc = "Copy line diagnostics" })

-- Manual Formatting Trigger
-- Trigger buffer formatting using conform.nvim
-- Sequentially runs external formatters (stylua, prettierd, etc.) based on filetype
-- Falls back to the active LSP formatter if no specific tool is configured
map({ "n", "v" }, "<leader>f", function()
	require("conform").format({
		lsp_fallback = true, -- Use LSP if no formatter is defined for this filetype
		async = true, -- Run in background to prevent UI lag
		timeout_ms = 500, -- Terminate if the formatter takes too long
	})
end, { desc = "Format buffer (Conform)" })

map("n", "<leader>q", vim.diagnostic.setqflist, { desc = "Open Diagnostic Quickfix List" })

map("n", "<leader>x", "<CMD>.lua<CR>", { desc = "Executes current lua line" })

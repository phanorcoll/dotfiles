-- ==========================================================================
-- 1. PACKAGE MANAGEMENT
-- ==========================================================================
vim.pack.add({
	"https://github.com/CopilotC-Nvim/CopilotChat.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/ibhagwan/fzf-lua",
})

-- Cache modules in the upvalue for performance
local chat_avail, chat = pcall(require, "CopilotChat")
if not chat_avail then
	return
end

--- Loads the selection utility module for CopilotChat.
-- This module provides functions to handle and manipulate text selections within Neovim,
-- enabling context-aware operations such as extracting, formatting, or processing selected text.
-- It is essential for features that require user-selected input, ensuring consistent and reliable selection handling.
local select = require("CopilotChat.select")

-- ==========================================================================
-- 2. CORE SETUP (Logic-Heavy Prompts)
-- ==========================================================================
chat.setup({
	headers = {
		user = "👤 code wizard ",
		assistant = "🤖 Copilot: ",
		tool = "🔧 Tool: ",
	},
	highlight_headers = true,
	error_header = "> [!ERROR] Error",
	separator = "━━",
	show_folds = false,
	model = "gemini-2.5-pro", -- AI model to use
	temperature = 0.2, -- Lower = focused, higher = creative
	window = {
		layout = "vertical", -- 'vertical', 'horizontal', 'float'
		width = 0.4, -- 50% of screen width
	},
	auto_insert_mode = false,
	-- window = {
	-- 	layout = "float", -- 'vertical', 'horizontal', 'float'
	-- 	relative = "editor",
	-- 	width = 0.8,
	-- 	height = 0.8,
	-- 	border = "rounded",
	-- 	zindex = 50, -- Ensure it stays above other floats
	-- },
	backend = "fzf",
	prompts = {
		Explain = {
			prompt = "/COPILOT_EXPLAIN Focus on data flow and state mutations. Avoid boilerplate descriptions.",
		},
		Review = {
			prompt = "/COPILOT_REVIEW Identify memory leaks, global pollution, and O(n^2) logic. Suggest idiomatic Lua/TS improvements.",
		},
		PRMessage = {
			prompt = "Write a Conventional PR message (feat/fix/refactor). Format as a gitcommit code block.",
			system_prompt = "You are a Principal Engineer. Use imperative, concise language.",
		},
		Doc = {
			prompt = [[
            Generate documentation for this symbol.
            - If TS/JS: Use TSDoc/JSDoc with @param, @returns, and @throws.
            - If Lua: Use EmmyLua/LDoc format (--- @param).
            - If Go: Use GoDoc style with clear parameter and return descriptions.
            - Focus on 'why' and constraints, not just 'what'.
        ]],
		},
		Optimize = {
			prompt = "Perform a Big O analysis. Suggest more efficient data structures (e.g., hash maps over linear searches).",
		},
	},
})

-- ==========================================================================
-- 3. UTILITIES
-- ==========================================================================

local function add_file_to_context()
	require("fzf-lua").files({
		actions = {
			["default"] = function(selected)
				local path = selected[1]:match("[^ ]+$")
				local abs_path = vim.fn.fnamemodify(path, ":p")

				-- Use Nvim's built-in fast IO to read content
				local ok, lines = pcall(vim.fn.readfile, abs_path)
				if not ok then
					return
				end

				chat.ask("Analysis request for file: " .. path .. "\n\nContent:\n" .. table.concat(lines, "\n"), {
					selection = function()
						return nil
					end,
				})
			end,
		},
	})
end

local function fix_diagnostic_with_ai()
	local line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local diagnostics = vim.diagnostic.get(0, { lnum = line })
	if #diagnostics == 0 then
		return
	end

	-- Sort by severity (Error > Warning)
	table.sort(diagnostics, function(a, b)
		return a.severity < b.severity
	end)

	chat.ask(
		"Fix this LSP "
			.. (vim.diagnostic.severity[diagnostics[1].severity] or "issue")
			.. ": "
			.. diagnostics[1].message,
		{
			selection = select.buffer,
		}
	)
end

-- ==========================================================================
-- 4. UNIFIED KEYMAPS (The "Source of Truth" approach)
-- ==========================================================================

local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { desc = "Copilot: " .. desc, silent = true, noremap = true })
end

-- Normal Mode: Context and Utility
map("n", "<leader>cs", ":CopilotChat<CR>", "Open chat")
map("n", "<leader>cf", add_file_to_context, "Add File Context")
map("n", "<leader>cd", fix_diagnostic_with_ai, "Fix Diagnostic")
map("n", "<leader>cm", function()
	chat.ask("Write commit message.", { selection = select.gitdiff })
end, "Commit Message")

-- Visual Mode: Prompt Actions
-- Using a loop for clean registration
local visual_actions = {
	e = { "Explain", "Explain Code" },
	r = { "Review", "Review Code" },
	f = { "Fix", "Fix Issues" },
	d = { "Doc", "Generate Docs" },
	t = { "Tests", "Generate Tests" },
	o = { "Optimize", "Optimize Code" },
}

for key, val in pairs(visual_actions) do
	map("v", "<leader>cp" .. key, function()
		chat.ask(val[1])
	end, val[2])
end

-- Quick Chat
map("v", "<leader>cq", function()
	local input = vim.fn.input("AI Chat: ")
	if input ~= "" then
		chat.ask(input, { selection = select.visual })
	end
end, "Quick Chat")

-- ==========================================================================
-- 5. UI POLISH & AUTOCOMMANDS
-- ==========================================================================
local ai_group = vim.api.nvim_create_augroup("CopilotSeniorUI", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = ai_group,
	pattern = "copilot-chat",
	callback = function()
		-- 1. Window-local options (wo)
		local wo = vim.wo[0] -- 0 refers to the current window
		wo.relativenumber = false
		wo.number = false
		wo.wrap = true
		wo.spell = true -- This was the culprit

		-- 2. Buffer-local mappings
		vim.keymap.set("n", "q", "<cmd>close<cr>", {
			buffer = true,
			silent = true,
			desc = "Close Chat",
		})
	end,
})

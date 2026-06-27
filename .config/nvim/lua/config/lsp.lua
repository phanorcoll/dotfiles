-------------------------------------------------------------------------------
-- LSP
-- Documentation: :help vim.lsp
-- This JUST enables the lsp servers.
-- The configuration is found in the lsp folder,
-- /lsp/lua_ls.lua for lua_ls, etc.

-- https://gpanders.com/blog/whats-new-in-neovim-0-11/ for an overview
-- on how the lsp setup works in neovim 0.11+.
-- NOTE: moved to use lspconfig + mason to handle LSP, linters etc.

-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end

		local bufnr = ev.buf
		local opts = { buffer = bufnr }

		-----------------------------------------------------------------------
		-- Completion & Hover
		-----------------------------------------------------------------------
		if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
			-- Sets completion options for the buffer [cite: 11, 12]
			vim.bo[bufnr].completeopt = "menu,menuone,noinsert,fuzzy"
		end

		-- Map 'K' to hover documentation [cite: 8, 11]
		vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))

		-----------------------------------------------------------------------
		-- Navigation & Search (FZF Integration with Toggle)
		-----------------------------------------------------------------------
		local fzf = require("fzf-lua")

		vim.keymap.set("n", "<leader>fw", function()
			-- Get the word under cursor using Neovim's expand
			local current_word = vim.fn.expand("<cword>")

			fzf.live_grep({
				search = current_word,
				winopts = {
					title = " Grep: " .. current_word .. " ",
					preview = {
						layout = "vertical", -- Better for side-by-side code comparison
						vertical = "down:60%",
					},
				},
			})
		end, { desc = "Fzf: Live Grep Word Under Cursor" })

		vim.keymap.set("n", "<leader>fr", function()
			local symbol = vim.fn.expand("<cword>") -- or vim.lsp.util.get_current_word()
			local title = string.format(" References for -> ( %s ) ", symbol)
			fzf.lsp_references({
				previewer = "bat", -- Uses fzf-lua's high-performance Lua previewer
				winopts = {
					title = title,
					preview = {
						layout = "vertical", -- Better for side-by-side code comparison
						vertical = "down:45%",
					},
				},
			})
		end, vim.tbl_extend("force", opts, { desc = "Find References (Project)" }))

		-- Standard LSP pickers via fzf-lua
		vim.keymap.set(
			"n",
			"<leader>fi",
			fzf.lsp_implementations,
			vim.tbl_extend("force", opts, { desc = "Find Implementations" })
		)
		vim.keymap.set("n", "<leader>fI", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_clients({ bufnr = bufnr })
			if #clients == 0 then
				vim.notify("No LSP client attached")
				return
			end

			-- Use current window ID (0), not bufnr
			local params = vim.lsp.util.make_position_params(0, clients[1].offset_encoding or "utf-16")

			vim.lsp.buf_request(bufnr, "textDocument/implementation", params, function(err, result, ctx, _)
				if err or not result or vim.tbl_isempty(result) then
					vim.notify("No implementations found")
					return
				end

				local encoding = clients[1].offset_encoding or "utf-16"
				local items = vim.lsp.util.locations_to_items(result, encoding)

				if #items == 0 then
					vim.notify("No implementations")
					return
				end

				-- Open first item in vsplit
				local first = items[1]
				vim.cmd.vsplit(first.filename)
				vim.api.nvim_win_set_cursor(0, { first.lnum, first.col - 1 })
				-- vim.notify(string.format("Opened %s:%d in vsplit", first.filename, first.lnum))
			end)
		end, vim.tbl_extend("force", opts, { desc = "Implementation (vsplit)" }))

		vim.keymap.set(
			"n",
			"<leader>ft",
			fzf.lsp_typedefs,
			vim.tbl_extend("force", opts, { desc = "Find Type Definitions" })
		)
		vim.keymap.set(
			"n",
			"<leader>fs",
			fzf.lsp_document_symbols,
			vim.tbl_extend("force", opts, { desc = "Document Symbols" })
		)

		-----------------------------------------------------------------------
		-- vtsls Specific Capabilities
		-----------------------------------------------------------------------
		if client.name == "vtsls" then
			vim.keymap.set("n", "<leader>co", function()
				client:request("workspace/executeCommand", {
					command = "typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(bufnr) },
				}, nil, bufnr)
			end, vim.tbl_extend("force", opts, { desc = "LSP: Organize Imports" }))

			vim.keymap.set("n", "<leader>cf", function()
				client:request("workspace/executeCommand", {
					command = "typescript.fixAll",
					arguments = { vim.api.nvim_buf_get_name(bufnr) },
				}, nil, bufnr)
			end, vim.tbl_extend("force", opts, { desc = "LSP: Fix All" }))
		end

		-----------------------------------------------------------------------
		-- Diagnostics & Refactoring
		-----------------------------------------------------------------------
		vim.keymap.set("n", "<leader>ld", function()
			vim.diagnostic.open_float({ scope = "line" })
		end, vim.tbl_extend("force", opts, { desc = "Line Diagnostics" }))
		vim.keymap.set("n", "<leader>ca", fzf.lsp_code_actions, vim.tbl_extend("force", opts, { desc = "Code Action" }))
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename Symbol" }))
	end,
})
-------------------------------------------------------------------------------
-- Diagnostics
-- inline diagnostics
-- Documentation: :help vim.diagnostci
-------------------------------------------------------------------------------
local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

vim.diagnostic.config({
	virtual_text = { prefix = "● ", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	virtual_lines = {
		--only shows virtual line diagnostic for the current cursor line
		current_line = true,
	},
	float = {
		border = "rounded",
		header = "-- Fix this --",
		prefix = "-> ",
		focusable = false,
		style = "minimal",
	},
})

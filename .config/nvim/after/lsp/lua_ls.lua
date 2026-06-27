return {
	-- Command and arguments to start the server.
	cmd = { "lua-language-server" },

	-- Filetypes to automatically attach to.
	filetypes = { "lua" },

	-- Sets the "root directory" to the parent directory of the file in the
	-- current buffer that contains either a ".luarc.json" or a
	-- ".luarc.jsonc" file. Files that share a root directory will reuse
	-- the connection to the same LSP server.
	-- Nested lists indicate equal priority, see |vim.lsp.Config|.
	-- root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	settings = {
		Lua = {
			hint = { enable = true },
			runtime = {
				-- Neovim uses LuaJIT (Lua 5.1)
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- This makes the server aware of Neovim runtime files
				library = {
					vim.env.VIMRUNTIME,
					-- Add specific plugins only if you need their types/completion
					-- "${3rd}/luv/library"
				},
				-- Stop "Do you want to configure your workdir as luadev?" popups
				checkThirdParty = false,
			},
		},
	},
}

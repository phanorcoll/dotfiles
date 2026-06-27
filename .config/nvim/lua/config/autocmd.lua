-------------------------------------------------------------------------------
-- 11. Autocmd
-- Documentation: :help 'autocmd'
-------------------------------------------------------------------------------
-- Define the "specter" (Augroup) to manage background events, organizing the events
-- in the GhostInTheBugger namespace.
local specter = vim.api.nvim_create_augroup("GhostInTheBuffer", { clear = true })

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text (copying)",
	group = specter,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Configure buffer-local settings for prose-heavy filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = specter,
	-- Target markdown, plain text, and git commit messages
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		-- Enable line wrapping, breaking at words, and spell checking
		local prose_settings = {
			wrap = true, -- Soft wrap lines
			linebreak = true, -- Don't break words in the middle
			spell = true, -- Turn on the spell checker
		}
		-- Apply each setting to the current buffer only
		for option, value in pairs(prose_settings) do
			vim.opt_local[option] = value
		end
	end,
})

vim.api.nvim_create_autocmd({ "FileType", "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("treesitter_force_start", { clear = true }),
	desc = "Force-start Tree-sitter for compatible filetypes (fixes hybrid files like .templ)",
	callback = function(args)
		local bufnr = args.buf
		local ft = vim.bo[bufnr].filetype

		-- 1. Ignore empty filetypes or common UI buffers
		if
			ft == ""
			or ft == "fzf"
			or ft == "oil"
			or ft == "confini"
			or ft == "NeogitConsole"
			or ft == "zsh"
			or ft == "gitconfig"
			or ft == "sh"
			or vim.bo[bufnr].buftype ~= ""
		then
			return
		end

		-- 2. Strictly check if Neovim has a parser for this language
		-- This prevents the "Parser could not be created" error for any plugin
		local has_lang = pcall(vim.treesitter.language.add, ft)

		if has_lang then
			-- Only start if the parser is actually available
			vim.treesitter.start(bufnr, ft)
		end
	end,
})

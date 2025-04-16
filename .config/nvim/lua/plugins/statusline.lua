-- url: https://github.com/echasnovski/mini.statusline
-- desc: Minimal, fast statusline plugin
return {
	"echasnovski/mini.statusline",
	version = "*",
	opts = {
		content = {
			active = function()
				local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
				local git = MiniStatusline.section_git({ trunc_width = 75 })
				local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
				-- local filename = MiniStatusline.section_filename({ trunc_width = 140 })
				local filename = (function()
					local filepath = vim.api.nvim_buf_get_name(0)
					if filepath == "" then
						return "[No Name]"
					end
					local dir = vim.fn.fnamemodify(filepath, ":h:t") -- last dir
					local file = vim.fn.fnamemodify(filepath, ":t") -- file name
					return string.format("%s/%s", dir, file)
				end)()
				local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
				-- local location = MiniStatusline.section_location({ trunc_width = 75 })
				local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

				return MiniStatusline.combine_groups({
					{ hl = mode_hl, strings = { mode } },
					{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
					"%<", -- Mark general truncate point
					{ hl = "MiniStatuslineFilename", strings = { filename } },
					"%=", -- End left alignment
					{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
					-- Exclude search and location here
					-- { hl = mode_hl, strings = { search, location } },
					{ hl = mode_hl, strings = { search } },
				})
			end,
		},
	},
}

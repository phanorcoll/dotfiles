-------------------------------------------------------------------------------
-- 9. CUSTOM LUA STATUSLINE (High Performance - Full Diagnostics)
-------------------------------------------------------------------------------

local uv = vim.uv or vim.loop

-- 1. Setup Highlight Groups
local function setup_colors()
	vim.api.nvim_set_hl(0, "StatusLineError", { fg = "#ff5555", bg = "none", bold = true })
	vim.api.nvim_set_hl(0, "StatusLineWarn", { fg = "#ffb86c", bg = "none", bold = true })
	vim.api.nvim_set_hl(0, "StatusLineHint", { fg = "#8be9fd", bg = "none", bold = true })
	vim.api.nvim_set_hl(0, "StatusLineInfo", { fg = "#bd93f9", bg = "none", bold = true }) -- Purple for Info
	vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true, reverse = true })
end
setup_colors()

-- 2. Git Branch (Cached)
local cached_branch = ""
local last_check = 0
local function git_branch()
	local now = uv.now()
	if now - last_check > 5000 then
		local handle = io.popen("git branch --show-current 2>/dev/null")
		if handle then
			local result = handle:read("*l")
			handle:close()
			cached_branch = result and result:gsub("%s+", "") or ""
		end
		last_check = now
	end
	return (cached_branch ~= "") and ("  " .. cached_branch .. " ") or ""
end

-- 3. Diagnostics Logic
local function diagnostics_info()
	-- Map severities to their counts
	local levels = {
		{ id = vim.diagnostic.severity.ERROR, hl = "StatusLineError", icon = " " },
		{ id = vim.diagnostic.severity.WARN, hl = "StatusLineWarn", icon = " " },
		{ id = vim.diagnostic.severity.INFO, hl = "StatusLineInfo", icon = " " },
		{ id = vim.diagnostic.severity.HINT, hl = "StatusLineHint", icon = "󰌵 " },
	}

	local parts = {}
	for _, level in ipairs(levels) do
		local n = #vim.diagnostic.get(0, { severity = level.id })
		if n > 0 then
			table.insert(parts, string.format("%%#%s#%s%d%%#StatusLine#", level.hl, level.icon, n))
		end
	end

	return #parts > 0 and (" " .. table.concat(parts, " ") .. " ") or ""
end

-- 4. File Type & Size Icons
local function file_info()
	local ft = vim.bo.filetype
	local icons = {
		lua = " ",
		python = " ",
		javascript = " ",
		typescript = " ",
		html = " ",
		css = " ",
		rust = " ",
		go = " ",
	}
	local icon = icons[ft] or " "
	local path = vim.fn.expand("%:p")
	local size_str = ""
	if path ~= "" and vim.fn.filereadable(path) == 1 then
		local size = vim.fn.getfsize(path)
		if size > 0 then
			local suffixes = { "B", "K", "M", "G" }
			local i = 1
			while size > 1024 and i < #suffixes do
				size = size / 1024
				i = i + 1
			end
			size_str = string.format(" 󰗮 %.1f%s", size, suffixes[i])
		end
	end
	return string.format("%s%s%s", icon, (ft ~= "" and ft or "none"), size_str)
end

-- 5. Mode Indicator
local function mode_indicator()
	local m = vim.fn.mode()
	local modes = {
		n = "  NORMAL",
		i = "  INSERT",
		v = "󰈈  VISUAL",
		V = "󰈈  V-LINE",
		[" "] = "󰈈  V-BLOCK",
		c = "  COMMAND",
		R = "  REPLACE",
		t = "  TERMINAL",
	}
	return (modes[m] or " ") .. " " .. m
end

_G.Statusline = {
	mode = mode_indicator,
	git = git_branch,
	diag = diagnostics_info,
	info = file_info,
}

-- 6. Statusline Construction
local function active_line()
	return table.concat({
		"%#StatusLineBold#",
		" %{v:lua.Statusline.mode()} ",
		"%#StatusLine#",
		"  %f %h%m%r ",
		"%{v:lua.Statusline.git()}",
		"%{%v:lua.Statusline.diag()%}",
		"%=", -- Right align
		"%{v:lua.Statusline.info()}",
		"  %l:%c  %P ",
	})
end

local function inactive_line()
	return "  %f %h%m%r %= %{v:lua.Statusline.info()}  %l:%c "
end

-- 7. Autocommands
local stl_group = vim.api.nvim_create_augroup("StatusLineCustom", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "ColorScheme" }, {
	group = stl_group,
	callback = function()
		setup_colors()
		vim.opt_local.statusline = active_line()
	end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = stl_group,
	callback = function()
		vim.opt_local.statusline = inactive_line()
	end,
})

-------------------------------------------------------------------------------
-- 5. THEME & UI CUSTOMIZATION
-- Documentation: :help gui, :help tui, and :help autocmd
-------------------------------------------------------------------------------
-- Enable 24-bit RGB colors
vim.opt.termguicolors = true

-- Set the default colorscheme (habamax is highly performant)
vim.cmd.colorscheme("habamax")

--- Function to strip background colors from UI components
local function set_transparent()
	local groups = {
		"Normal", -- normal text
		"NormalNC", -- normal text in non-current windows
		"EndOfBuffer", -- filler lines (~) after the last line
		"NormalFloat", -- actual floating windows
		"FloatBorder", -- border of floating windows
		-- "SignColumn", -- column where signs (gutters) are displayed
		"StatusLine", -- status line of current window
		"StatusLineNC", -- status lines of non-current windows
		"TabLine", -- tab pages line
		"TabLineFill", -- tab pages line filler
		"TabLineSel", -- active tab page label
		"ColorColumn",  -- the vertical ruler
	}

	for _, g in ipairs(groups) do
		-- Set background to "none" using the modern Nvim API
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end

	-- Specific override to keep the TabLineFill readable
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

-- Define an Autocommand Group to prevent duplicate registrations
local trans_group = vim.api.nvim_create_augroup("TransparentWindow", { clear = true })

-- Apply transparency whenever a colorscheme is loaded
vim.api.nvim_create_autocmd("ColorScheme", {
	group = trans_group,
	desc = "Maintain transparency across theme changes",
	callback = function()
		set_transparent()
	end,
})

-- Initial invocation for the current session
set_transparent()

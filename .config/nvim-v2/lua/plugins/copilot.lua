-- url: https://github.com/zbirenbaum/copilot.lua
-- desc: A Lua wrapper for Copilot, the AI pair programmer.
return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
		filetypes = {
			markdown = true,
			help = true,
		},
	},
}

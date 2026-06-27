vim.pack.add({
	"https://github.com/theHamsta/nvim-dap-virtual-text",
})

require("nvim-dap-virtual-text").setup({
	enabled = true,
	enabled_commands = true,
	highlight_changed_variables = true,
	highlight_new_as_changed = false,
	show_stop_reason = true,
	commented = true,
	only_first_definition = true,
	all_references = false,
	clear_on_continue = false,
})

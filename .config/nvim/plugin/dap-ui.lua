vim.pack.add({
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/nvim-neotest/nvim-nio",
})

local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.75 },
				{ id = "breakpoints", size = 0.25 },
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				{ id = "repl", size = 0.5 },
				{ id = "console", size = 0.5 },
			},
			size = 10,
			position = "bottom",
		},
	},
	floating = {
		border = "rounded",
	},
})

vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI", silent = true })
vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "DAP: Evaluate expression", silent = true })
vim.keymap.set("v", "<leader>de", dapui.eval, { desc = "DAP: Evaluate selection", silent = true })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

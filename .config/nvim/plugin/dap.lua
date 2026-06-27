vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
})

local dap = require("dap")

vim.fn.sign_define("DapBreakpoint", {
	text = "●",
	texthl = "DiagnosticSignError",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapBreakpointCondition", {
	text = "◆",
	texthl = "DiagnosticSignWarn",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapLogPoint", {
	text = "◆",
	texthl = "DiagnosticSignInfo",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapStopped", {
	text = "▶",
	texthl = "DiagnosticSignHint",
	linehl = "Visual",
	numhl = "DiagnosticSignHint",
})

vim.fn.sign_define("DapBreakpointRejected", {
	text = "○",
	texthl = "DiagnosticSignError",
	linehl = "",
	numhl = "",
})

local function map(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { desc = "DAP: " .. desc, silent = true })
end

map("<leader>dc", dap.continue, "Start/Continue")
map("<leader>dt", dap.terminate, "Terminate")
map("<leader>do", dap.step_over, "Step over")
map("<leader>di", dap.step_into, "Step into")
map("<leader>dO", dap.step_out, "Step out")
map("<leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
map("<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "Set conditional breakpoint")
map("<leader>dl", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, "Set log point")
map("<leader>dr", dap.repl.open, "Open REPL")
map("<leader>dR", dap.run_last, "Run last")

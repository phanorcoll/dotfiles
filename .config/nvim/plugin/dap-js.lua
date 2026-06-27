vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
})

local dap = require("dap")
local js_debug_server = vim.fn.stdpath("data")
	.. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

local function file_dirname()
	return vim.fn.expand("%:p:h")
end

for _, adapter in ipairs({ "pwa-node", "node-terminal" }) do
	dap.adapters[adapter] = {
		type = "server",
		host = "127.0.0.1",
		port = "${port}",
		executable = {
			command = "node",
			args = { js_debug_server, "${port}", "127.0.0.1" },
		},
	}
end

local node_configs = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch current file",
		program = "${file}",
		cwd = "${workspaceFolder}",
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch current file from file directory",
		program = "${file}",
		cwd = file_dirname,
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		type = "pwa-node",
		request = "attach",
		name = "Attach to Node process",
		processId = require("dap.utils").pick_process,
		cwd = "${workspaceFolder}",
		sourceMaps = true,
		protocol = "inspector",
	},
	{
		type = "pwa-node",
		request = "launch",
		name = "Debug Jest current file",
		runtimeExecutable = "node",
		runtimeArgs = {
			"./node_modules/.bin/jest",
			"${file}",
			"--runInBand",
		},
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
		sourceMaps = true,
	},
	{
		type = "node-terminal",
		request = "launch",
		name = "Run npm start",
		command = "npm start",
		cwd = "${workspaceFolder}",
	},
}

for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
	dap.configurations[language] = node_configs
end

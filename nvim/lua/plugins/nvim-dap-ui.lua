return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"nvim-neotest/nvim-nio",
		{
			"mfussenegger/nvim-dap",
			config = function()
				local dap, dapui = require("dap"), require("dapui")

				-- Auto open/close the dap UI around sessions
				dap.listeners.before.attach.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.launch.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated.dapui_config = function()
					dapui.close()
				end
				dap.listeners.before.event_exited.dapui_config = function()
					dapui.close()
				end

				-- C / C++ debugging via lldb-dap (ships with Xcode Command Line Tools)
				local lldb_dap = vim.fn.exepath("lldb-dap")
				if lldb_dap == "" then
					lldb_dap = "/Library/Developer/CommandLineTools/usr/bin/lldb-dap"
				end

				dap.adapters.lldb = {
					type = "executable",
					command = lldb_dap,
					name = "lldb",
				}

				dap.configurations.c = {
					{
						name = "Launch",
						type = "lldb",
						request = "launch",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
						end,
						cwd = "${workspaceFolder}",
						stopOnEntry = false,
						args = {},
					},
				}
				dap.configurations.cpp = dap.configurations.c

				-- Keymaps
				local map = vim.keymap.set
				map("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
				map("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
				map("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
				map("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
				map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
				map("n", "<leader>dB", function()
					dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end, { desc = "Debug: Conditional Breakpoint" })
				map("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
				map("n", "<leader>dr", dap.repl.toggle, { desc = "Debug: Toggle REPL" })
				map("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })
				map("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })
				map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
			end,
		},
	},
	config = function()
		require("dapui").setup()
	end,
}

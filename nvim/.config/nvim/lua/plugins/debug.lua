---@type LazySpec
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"microsoft/vscode-js-debug",
				version = "1.*",
				build = "npm install --legacy-peer-deps --no-save --ignore-scripts && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
			},
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio", -- зависимость dap-ui
			"theHamsta/nvim-dap-virtual-text",
			"leoluz/nvim-dap-go", -- Go через delve (dlv)
		},
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Condition: "))
				end,
				desc = "Conditional breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Start / continue",
			},
			{
				"<leader>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Run to cursor",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Step over",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "Step out",
			},
			{
				"<leader>dp",
				function()
					require("dap").pause()
				end,
				desc = "Pause",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run last",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle debug UI",
			},
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				mode = { "n", "v" },
				desc = "Eval expression",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- UI
			dapui.setup()
			require("nvim-dap-virtual-text").setup({})
			require("dap-go").setup()

			dap.listeners.after.event_initialized["dapui"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui"] = function()
				dapui.close()
			end

			-- Иконки breakpoint'ов
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })

			-- Адаптеры js-debug
			local js_debug = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/vsDebugServer.js"
			for _, type in ipairs({ "pwa-node", "pwa-chrome" }) do
				dap.adapters[type] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = { command = "node", args = { js_debug, "${port}" } },
				}
			end

			-- Конфигурации для JS / TS / Vue
			local configs = {
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Chrome: open URL (Vite / Nuxt dev)",
					url = function()
						return vim.fn.input("URL: ", "http://localhost:5173")
					end,
					webRoot = function()
						return vim.fn.input("webRoot: ", vim.fn.getcwd(), "dir")
					end,
					sourceMaps = true,
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Node: current file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-chrome",
					request = "attach",
					name = "Chrome: attach (9222)",
					port = 9222,
					webRoot = "${workspaceFolder}",
					sourceMaps = true,
				},
			}
			for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }) do
				dap.configurations[ft] = configs
			end
		end,
	},
}

--# selene: allow(mixed_table)

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"jay-babu/mason-nvim-dap.nvim",

			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"nvim-neotest/nvim-nio",
				},
			},

			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				ensure_installed = {
					"python", -- debugpy
					"delve", -- Go
					"codelldb", -- C / C++ / Rust
					"js", -- JavaScript / TypeScript
					"coreclr", -- C#
					"bash", -- Bash
				},

				automatic_installation = true,

				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})

			require("nvim-dap-virtual-text").setup({})

			dapui.setup({
				icons = {
					expanded = "▾",
					collapsed = "▸",
					current_frame = "▸",
				},

				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.35 },
							{ id = "breakpoints", size = 0.15 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 12,
						position = "bottom",
					},
				},
			})

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

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end

			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			------------------------------------------------------------------
			-- JavaScript / TypeScript via js-debug-adapter
			------------------------------------------------------------------
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "js-debug-adapter",
					args = { "${port}" },
				},
			}

			for _, language in ipairs({
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			}) do
				dap.configurations[language] = {
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
						request = "attach",
						name = "Attach to process",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end

			------------------------------------------------------------------
			-- Python
			------------------------------------------------------------------
			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch current file",
					program = "${file}",
					pythonPath = function()
						local venv = os.getenv("VIRTUAL_ENV")
						if venv then
							return venv .. "/bin/python"
						end

						return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
					end,
				},
			}

			------------------------------------------------------------------
			-- Go
			------------------------------------------------------------------
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug current file",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug package",
					request = "launch",
					program = "${fileDirname}",
				},
			}

			------------------------------------------------------------------
			-- C / C++ / Rust
			------------------------------------------------------------------
			local codelldb_config = {
				{
					name = "Launch executable",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			dap.configurations.c = codelldb_config
			dap.configurations.cpp = codelldb_config
			dap.configurations.rust = codelldb_config

			------------------------------------------------------------------
			-- C#
			------------------------------------------------------------------
			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Launch .NET DLL",
					request = "launch",
					program = function()
						return vim.fn.input("Path to DLL: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}

			------------------------------------------------------------------
			-- Keymaps
			------------------------------------------------------------------
			vim.keymap.set("n", "<F5>", dap.continue, {
				desc = "DAP Continue",
			})

			vim.keymap.set("n", "<F10>", dap.step_over, {
				desc = "DAP Step Over",
			})

			vim.keymap.set("n", "<F11>", dap.step_into, {
				desc = "DAP Step Into",
			})

			vim.keymap.set("n", "<F12>", dap.step_out, {
				desc = "DAP Step Out",
			})

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {
				desc = "DAP Toggle Breakpoint",
			})

			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, {
				desc = "DAP Conditional Breakpoint",
			})

			vim.keymap.set("n", "<leader>dl", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, {
				desc = "DAP Log Point",
			})

			vim.keymap.set("n", "<leader>dr", dap.repl.open, {
				desc = "DAP Open REPL",
			})

			vim.keymap.set("n", "<leader>du", dapui.toggle, {
				desc = "DAP Toggle UI",
			})

			vim.keymap.set("n", "<leader>dt", dap.terminate, {
				desc = "DAP Terminate",
			})

			vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, {
				desc = "DAP Run to Cursor",
			})
		end,
	},
}


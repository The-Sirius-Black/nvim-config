return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"tpope/vim-fugitive",
		},
		config = function()
			require("dapui").setup()
			require("dap-go").setup()

			local dap, dapui = require("dap"), require("dapui")

			local repl = require("dap.repl")

			dap.set_log_level("TRACE")

			repl.commands = vim.tbl_extend("force", repl.commands, {
				custom_commands = {
					[".hot-reload"] = function()
						dap.session():request("hotReload")
					end,
					[".hot-restart"] = function()
						dap.session():request("hotRestart")
					end,
				},
			})

			vim.keymap.set("n", "<Leader>hr", function()
				dap.session():request("hotReload")
			end)

			vim.keymap.set("n", "<Leader>re", function()
				dap.session():request("hotRestart")
			end)

			local flutterBin = vim.fn.resolve(vim.fn.exepath("flutter.bat"))
			local flutterSdk = vim.fn.fnamemodify(flutterBin, ":h:h")
			local dartSdk = flutterSdk .. "\\bin\\cache\\dart-sdk"

			--[[
      FOR MAC USE THIS
      dap.adapters.dart = {
        type = "executable",
        command = "flutter",
        args = { "debug_adapter" },
      }
 --]]

			dap.adapters.dart = {
				type = "executable",
				command = flutterBin,
				--vim.fn.exepath("cmd.exe"),
				args = { "/c", flutterBin, "debug_adapter" },
				options = {
					detached = false,
				},
			}

			dap.configurations.dart = {
				{
					type = "dart",
					request = "launch",
					name = "Launch Flutter windows",
					dartSdkPath = dartSdk,
					flutterSdkPath = flutterSdk,
					program = "${workspaceFolder}\\lib\\main.dart",
					cwd = "${workspaceFolder}",
					toolArgs = { "-d", "windows" },
					sendLogsToClient = true,
				},
			}
			--[[
      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch Flutter Program",
          -- The nvim-dap plugin populates this variable with the filename of the current buffer
          program = "${file}",
          -- The nvim-dap plugin populates this variable with the editor's current working directory
          cwd = "${workspaceFolder}",
          -- This gets forwarded to the Flutter CLI tool, substitute `linux` for whatever device you wish to launch
          toolArgs = {
            "windows",
          },
        },
        {
          type = "dart",
          request = "launch",
          name = "Launch Flutter Program",
          -- The nvim-dap plugin populates this variable with the filename of the current buffer
          program = "${file}",
          -- The nvim-dap plugin populates this variable with the editor's current working directory
          cwd = "${workspaceFolder}",
          -- This gets forwarded to the Flutter CLI tool, substitute `linux` for whatever device you wish to launch
          toolArgs = {
            "-d",
            "iPhone 14 Pro",
            "lib/main.dart",
          },
        },
      }
      --]]

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

			vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
			vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
			vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
			vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
		end,
	},
}

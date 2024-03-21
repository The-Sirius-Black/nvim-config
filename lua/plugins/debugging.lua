return {
  {
    "jbyuki/one-small-step-for-vimkind",
  },
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

      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      end

      vim.keymap.set("n", "<Leader>hr", function()
        dap.session():request("hotReload")
      end)

      vim.keymap.set("n", "<Leader>re", function()
        dap.session():request("hotRestart")
      end)

      vim.api.nvim_set_keymap("n", "<F5>", [[:lua require"osv".launch({port = 8086})<CR>]], { noremap = true })

      local flutterBin = vim.fn.resolve(vim.fn.exepath("flutter.bat"))
      local flutterSdk = vim.fn.fnamemodify(flutterBin, ":h:h")
      local dartSdk = flutterSdk .. "\\bin\\cache\\dart-sdk"

      dap.adapters.dart = {
        command = "C:\\Users\\duc\\AppData\\Local\\nvim-data\\mason\\bin\\dart-debug-adapter.CMD",
        args = { "/c", flutterBin, "debug_adapter" },
        options = {
          detached = false,
        },
      }

      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch Flutter",
          dartSdkPath = dartSdk,
          flutterSdkPath = flutterSdk,
          program = "${workspaceFolder}\\lib\\main.dart",
          cwd = "${workspaceFolder}",
          toolArgs = { "-d", "windows" },
          sendLogsToClient = true,
        },
      }

      --[[
      FOR MAC USE THIS
      dap.adapters.dart = {
        type = "executable",
        command = "flutter",
        args = { "debug_adapter" },
      }
 --]]

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

      vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#ff0000" })
      vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef" })
      vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379" })

      vim.fn.sign_define("DapBreakpoint", { text = " ●", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointCondition", { text = " ﳁ", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DapLogPoint" })
      vim.fn.sign_define("DapStopped", { text = " ", texthl = "DapStopped" })
    end,
  },
}

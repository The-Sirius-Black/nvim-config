-- lsp config 
return {
    {"dart-lang/dart-vim-plugin"}, {'L3MON4D3/LuaSnip'},
    {
        "williamboman/mason.nvim",
        config = function() require('mason').setup() end
    }, {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                 PATH = "prepend",
                ensure_installed = {"lua_ls", "golangci_lint_ls"}
            })
        end

    },  {
        "mfussenegger/nvim-dap",

        config = function()

            vim.keymap.set('n', '<F5>', function()
                require('dap').continue()
            end)

            vim.keymap.set('n', '<F10>',
                           function() require('dap').step_over() end)

            vim.keymap.set('n', '<F11>',
                           function() require('dap').step_into() end)

            vim.keymap.set('n', '<F12>',
                           function() require('dap').step_out() end)

            vim.keymap.set('n', '<Leader>b',
                           function()
                require('dap').toggle_breakpoint()
            end)

            vim.keymap.set('n', '   <Leader>B',
                           function() require('dap').set_breakpoint() end)

            vim.keymap.set('n', '<Leader>lp', function()
                require('dap').set_breakpoint(nil, nil, vim.fn
                                                  .input('Log point message: '))
            end)

            vim.keymap.set('n', '<Leader>dr',
                           function() require('dap').repl.open() end)

            vim.keymap.set('n', '<Leader>dl',
                           function() require('dap').run_last() end)

            vim.keymap.set({'n', 'v'}, '<Leader>dh',
                           function()
                require('dap.ui.widgets').hover()
            end)

            vim.keymap.set({'n', 'v'}, '<Leader>dp',
                           function()
                require('dap.ui.widgets').preview()
            end)

            vim.keymap.set('n', '<Leader>df', function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.frames)
            end)

            vim.keymap.set('n', '<Leader>ds', function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes)
            end)
        end
    }, {
        "akinsho/flutter-tools.nvim",
        dependencies = {"nvim-lua/plenary.nvim", "stevearc/dressing.nvim"},
        config = function()
            require("flutter-tools").setup {
                -- for windowns only
                flutter_path = 'C:/flutter/flutter/bin/dart.bat',
                --
                ui = {border = "rounded", notification_style = "plugin"},
                outline = {open_cmd = "30vnew", auto_open = false},
                closing_tags = {
                    highlight = "Comment",
                    prefix = "// ",
                    enabled = true
                },
                debugger = {
                    enabled = true,
                    run_via_dap = true,
                    register_configurations = function(_)


                        local flutterBin =
                            vim.fn.resolve(vim.fn.exepath('C:/flutter/flutter/bin/dart.bat'))


                        local flutterSdk = vim.fn.fnamemodify(flutterBin, ":h:h")


                        print("flutterBin:", flutterBin)
                        print("flutterSdk:", flutterSdk)
                        
                        require('dap').set_log_level('TRACE')

                       -- require('dap.ext.vscode').load_launchjs(nil, {})

                        require("dap").adapters.dart = {
                            type = 'executable',
                            command = vim.fn.exepath('cmd.exe'),
                            args = {'/c', flutterBin, 'debug_adapter'},
                            options = {
                                detached = false,
                            }
                        }

                      --  require('dap.ext.vscode').load_launchjs(nil, {})

                        require("dap").configurations.dart = {
                            {
                                type = "dart",
                                request = "launch",
                                name = "Launch Flutter",
                                dartSdkPath = "C:/flutter/flutter/bin/cache/dart-sdk/",
                                flutterSdkPath = flutterSdk,
                                program = "${workspaceFolder}/lib/main.dart",
                                cwd = "${workspaceFolder}",
                                toolsArgs = {'-d', 'windows'},
                                sendLogsToClient = true,
                           }
                        }

                    end
                },
                -- dev_log = {enabled = false, open_cmd = "tabedit"},
                lsp = {
                    -- on_attach = require("lvim.lsp").common_on_attach,
                    color = {
                        enabled = true,
                        background = false,
                        background_color = {r = 220, g = 223, b = 228},
                        foreground = false,
                        virtual_text = true,
                        virtual_text_str = "■"
                    },
                    settings = {
                        showTodos = true,
                        completeFunctionCalls = true,
                        renameFilesWithClasses = "prompt",
                        enableSnippets = true,
                        enableSdkFormatter = true,
                        analysisExcludedFolders = {".dart_tool"}
                    }
                    -- capabilities = require("lvim.lsp").default_capabilities
                }
            }
        end
    },
     {
        'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup({})
            lspconfig.golangci_lint_ls.setup({})
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap
                .set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
        end
    }, 
}

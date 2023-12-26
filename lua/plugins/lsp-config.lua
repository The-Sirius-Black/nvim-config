return {
    {
        "williamboman/mason.nvim",
        config = function() require('mason').setup() end
    }, {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {"lua_ls", "golangci_lint_ls"}
            })
        end

    }, {
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
    }, {
        "mskelton/flutter.nvim",
        dependencies = {"neovim/nvim-lspconfig"},
        config = function()
            require('flutter').setup({
                closing_labels = {
                    prefix = '==> ',
                    highlight = 'Comment',
                    enabled = true

                },
                hot_reload = true
            })
        end
    }
}

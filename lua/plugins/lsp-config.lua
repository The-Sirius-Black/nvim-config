-- lsp config 
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
        'akinsho/flutter-tools.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
            config = function() require("flutter-tools").setup({}) end
        }

    }
}

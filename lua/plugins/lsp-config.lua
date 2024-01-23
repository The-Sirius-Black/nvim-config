return {
	{
		"akinsho/flutter-tools.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
			config = function()
				require("flutter-tools").setup({
					flutter_lookup_cmd = "C:/flutter/flutter/bin",
					lsp = {
						settings = {
							lineLength = 120,
						},
					},
				})
				require("telescope").load_extension("flutter")
			end,
		},
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
			pcall(vim.cmd, "MasonUpdate")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = { auto_install = true },
		config = function()
			require("mason-lspconfig").setup({
				PATH = "prepend",
				ensure_installed = { "lua_ls", "golangci_lint_ls", "tsserver" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,

		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			--[[			lspconfig.dartls.setup({
				capabilities = capabilities,
				settings = {
					dart = {
						lineLength = 120,
					},
				},
			})
            ]]
			--
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.html.setup({
				capabilities = capabilities,
			})

			lspconfig.golangci_lint_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
		end,
	},
}

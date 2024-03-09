local function is_dart_project()
	local result = vim.fn.glob("pubspec.yaml") ~= ""
	return result
end

return {
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({})
		end,
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
				ensure_installed = { "lua_ls", "golangci_lint_ls", "tsserver", "clangd" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			if is_dart_project() then
				lspconfig.dartls.setup({
					capabilities = capabilities,
					filetypes = { "dart" },
					settings = {
						dart = {
							lineLength = 120,
						},
					},
				})
			end

			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				filetypes = { "rust" },
			})

			lspconfig.jsonls.setup({
				capabilities = capabilities,
				filetypes = { "json", "jsonc" },
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				filetypes = { "lua" },
			})

			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html" },
			})

			lspconfig.golangci_lint_ls.setup({
				capabilities = capabilities,
				filetypes = { "go" },
			})

			lspconfig.tsserver.setup({
				capabilities = capabilities,
				filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
				filetypes = { "c", "cpp" },
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
		end,
	},
}

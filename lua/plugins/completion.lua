return {
	{
		"VonHeikemen/lsp-zero.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{
				"L3MON4D3/LuaSnip",
				config = function()
					-- enable flutter snippets
					local luasnip = require("luasnip")
					luasnip.filetype_extend("dart", { "flutter" })
					luasnip.filetype_extend("go")
				end,
			},
			{ "SmiteshP/nvim-navic" },
		},
		config = function()
			local lsp = require("lsp-zero").preset({})

			local navic = require("nvim-navic")

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
				if client.server_capabilities.documentSymbolProvider then
					navic.attach(client, bufnr)
				end
			end)

			require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

			lsp.ensure_installed({
				"lua_ls",
				"gopls",
				"clangd",
			})

			lsp.setup()

			local cmp = require("cmp")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				preselect = cmp.PreselectMode.None,
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
				mapping = {
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
			})
		end,
	},
	{ "saadparwaiz1/cmp_luasnip" },
	{ "rafamadriz/friendly-snippets" },
}

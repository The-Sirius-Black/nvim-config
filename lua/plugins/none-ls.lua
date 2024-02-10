return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- lua
				null_ls.builtins.formatting.stylua,
				-- js
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.eslint,
				--python
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.black,
				--json
				null_ls.builtins.formatting.jsonnetfmt,
			},
		})

		vim.keymap.set("n", "<leader>fc", vim.lsp.buf.format, {})
	end,
}

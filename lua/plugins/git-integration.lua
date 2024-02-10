return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
			vim.keymap.set("n", "<leader>th", ":Gitsigns preview_hunk<CR>", {})
			vim.keymap.set("n", "<leader>tb", ":Gitsigns toggle_current_line_blame<CR>", {})
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup()
		end,
	},
	{
		"tpope/vim-fugitive",
		event = "VimEnter",
	},
}

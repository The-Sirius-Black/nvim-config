return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<C-w>", ":Neotree filesystem reveal left<CR>", {})
		require("neo-tree").setup({
			event_handlers = {
				{
					event = "file_opened",
					handler = function(_)
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
				{
					event = "neo_tree_buffer_enter",
					handler = function()
						vim.opt_local.relativenumber = true
					end,
				},
			},
		})
	end,
}

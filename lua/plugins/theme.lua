return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	config = function()
		require("kanagawa").load("wave")
	end,
	--[[
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	flavour = "frappe",
	config = function()
      vim.cmd.colorscheme("catppucci)
	end,
	show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	dim_inactive = {
		enabled = false, -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    background = { -- :h background
		light = "latte",
		dark = "frappe",
	},--]]
	--
}

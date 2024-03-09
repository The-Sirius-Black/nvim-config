return {
	--[[
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  flavour = "frappe",
  config = function()
    vim.cmd.colorscheme("catppuccin")
  end,
  show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  dim_inactive = {
    enabled = false,         -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.15,       -- percentage of the shade to apply to the inactive window
  },
  background = {             -- :h background
    light = "latte",
    dark = "frappe",
  },
  ]]
	--
	"EdenEast/nightfox.nvim",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("nordfox")
		require("nightfox.palette").load("nordfox")
	end,
}

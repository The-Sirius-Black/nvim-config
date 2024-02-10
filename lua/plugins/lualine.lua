return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local val = [[hello]]
		vim.keymap.set("n", "<C-x>", function()
			val = [[test]]
			require("lualine").refresh({
				scope = "tabpage", -- scope of refresh all/tabpage/window
				place = { "statusline", "winbar", "tabline" }, -- lualine segment ro refresh.
			})
		end, {})

		local function hello()
			return val
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "powerline_dark",

				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_c = { "diagnostics" },
				lualine_b = { "branch", "diff" },
				lualine_a = { "filename" },
				lualine_x = { hello, "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
			},
		})
	end,
}

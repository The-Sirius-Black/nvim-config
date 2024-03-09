-- to preview keymappings run :lua Cheatsheet()

local content = [[
┌───────┬──────────────┬────────────────────────────────────────────────────── DEBUGGER ─┐
│ Mode  │ Keys         │ Action                                                          │
├───────┼──────────────┼─────────────────────────────────────────────────────────────────┤
│   n   │ <leader>hr   │ hotReload                                                       │
│   n   │ <leader>re   │ hotRestart                                                      │
│   n   │ <leader>dc   │ DapContinue                                                     │
│   n   │ <leader>dx   │ DapTerminate                                                    │
│   n   │ <leader>do   │ DapStepOver                                                     │
│   n   │ <leader>dt   │ DapToggleBreakpoint                                             │
└───────┴──────────────┴─────────────────────────────────────────────────────────────────┘

┌───────┬──────────────┬─────────────────────────────────────────────────────── HARPOON ─┐
│ Mode  │ Keys         │ Action                                                          │
├───────┼──────────────┼─────────────────────────────────────────────────────────────────┤
│   n   │ <leader>h    │ harpoon_mark.add_file                                           │
│   n   │ <C─h>        │ harpoon_ui.toggle_quick_menu                                    │
│   n   │ <leader>1─9  │ harpoon_ui.nav_file(1 ─ 9)                                      │
└───────┴──────────────┴─────────────────────────────────────────────────────────────────┘

┌───────┬──────────────┬──────────────────────────────────────────────────────── SEARCH ─┐
│ Mode  │ Keys         │ Action                                                          │
├───────┼──────────────┼─────────────────────────────────────────────────────────────────┤
│   n   │ <leader>ff   │ find_files                                                      │
│   n   │ <leader>fg   │ live_grep                                                       │
│   n   │ <leader>cs   │ nohlsearch                                                      │
└───────┴──────────────┴─────────────────────────────────────────────────────────────────┘

┌───────┬──────────────┬────────────────────────────────────────────────── AUTOCOMPLETE ─┐
│ Mode  │ Keys         │ Action                                                          │
├───────┼──────────────┼─────────────────────────────────────────────────────────────────┤
│   i   │ <C─b>        │ cmp.mappings.scroll_docs(─4)                                    │
│   i   │ <C─f>        │ cmp.mappings.scroll_docs(4)                                     │
│   i   │ <C─Space>    │ cmp.mapping.complete                                            │
│   i   │ <C─e>        │ cmp.mappng.abort                                                │
│   i   │ <CR>         │ cmp.mapping.confirm({select = true})                            │
└───────┴──────────────┴─────────────────────────────────────────────────────────────────┘

┌───────┬──────────────┬─────────────────────────────────────────────────────── FLUTTER ─┐
│ Mode  │ Keys         │ Action                                                          │
├───────┼──────────────┼─────────────────────────────────────────────────────────────────┤
│   n   │ <leader>far  │ run_flutter_tools                                               │
│   n   │ <leader>fr   │ flutter_hot_reload                                              │
│   n   │ <leader>ffr  │ flutter_hot_restart                                             │
│   n   │ <leader>faq  │ flutter_quit_app()                                              │
│   n   │ <leader>fe   │ show_flutter_emulators                                          │
└───────┴──────────────┴─────────────────────────────────────────────────────────────────┘

┌───────┬──────────────┬───────────────────────────────────────────────────────── OTHER ─┐
│ Mode  │ Keys         │ Action                                                          │
├───────┼──────────────┼─────────────────────────────────────────────────────────────────┤
│   n   │ <C─s>        │ :w                                                              │
│   n   │ <C─a>        │ :wa                                                             │
│   n   │ <Leader>sh   │ OpenDefaultShell                                                │
│   n   │ <C─o>        │ SymbolsOutlineOpen                                              │
│   n   │ <leader>fc   │ vim.lsp.buf.format                                              │
│   n   │ <leader>th   │ Gitsigns preview_hunk                                           │
│   n   │ <leader>tb   │ Gitsigns toggle_current_line_blame                              │
│ n,v,i │ <F1>         │ set relativenumber                                              │
│ n,v,i │ <F2>         │ set norelativenumber                                            │
└───────┴──────────────┴─────────────────────────────────────────────────────────────────┘

┌───────────────────────────────────────────────────────────────────────────── DEFAULTS ─┐
│ set expandtab                                                                          │
│ set tabstop=2                                                                          │
│ set softtabstop=2                                                                      │
│ set shiftwidth=2                                                                       │
│ set colorcolumn=120                                                                    │
│ vim.wo.number = true                                                                   │
│ vim.wo.relativenumber = true                                                           │
│ vim.g.mapleader = " "                                                                  │
└────────────────────────────────────────────────────────────────────────────────────────┘
]]

local width_percent = 0.355
local height_percent = 0.95

local lines = {}
for line in content:gmatch("[^\r\n]+") do
	table.insert(lines, line)
end

local function getSize()
	local width = 90
	local height = 65
	return width, height
end

local function getWindowCenter()
	local rows = vim.api.nvim_get_option("lines")
	local cols = vim.api.nvim_get_option("columns")

	local width = math.floor(cols * width_percent)
	local height = math.floor(rows * height_percent)

	local y = math.floor((rows - height) / 2)
	local x = math.floor((cols - width) / 2)

	return x, y
end

function Cheatsheet()
	local width, height = getSize()
  print(width, height)
	local cols, rows = getWindowCenter()
	local buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		col = cols,
		row = rows,
		border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
	}

	local win = vim.api.nvim_open_win(buf, true, opts)

	vim.api.nvim_win_set_option(win, "relativenumber", false)
	vim.api.nvim_win_set_option(win, "number", false)
	vim.api.nvim_win_set_option(win, "colorcolumn", "")
	vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal")
end

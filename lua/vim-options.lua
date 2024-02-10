vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set colorcolumn=120")
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.mapleader = " "
vim.keymap.set("n", "<C-s>", ":w<CR>", {})
vim.keymap.set("n", "<C-a>", ":wa<CR>", {})
vim.keymap.set({ "n", "v", "i" }, "<F1>", ":set relativenumber<CR>", {})
vim.keymap.set({ "n", "v", "i" }, "<F2>", ":set norelativenumber<CR>", {})

--disable arrows
vim.keymap.set({ "n", "v", "i" }, "<Up>", "<NOP>", {})
vim.keymap.set({ "n", "v", "i" }, "<Down>", "<NOP>", {})
vim.keymap.set({ "n", "v", "i" }, "<Left>", "<NOP>", {})
vim.keymap.set({ "n", "v", "i" }, "<Right>", "<NOP>", {})

function OpenDefaultShell()
	vim.cmd("set splitright")
	vim.cmd(":vsplit | term")
end

vim.api.nvim_set_keymap("n", "<Leader>sh", ":lua OpenDefaultShell()<CR>", { noremap = true, silent = true })

-- Flutter

-- Command to trigger running all Flutter tools
vim.api.nvim_set_keymap("n", "<leader>far", ":lua run_flutter_tools()<CR>", {
	noremap = true,
	silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>fr", ":lua flutter_hot_reload()<CR>", {
	noremap = true,
	silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>ffr", ":lua flutter_hot_restart()<CR>", {
	noremap = true,
	silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>faq", ":lua flutter_quit_app()<CR>", {
	noremap = true,
	silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>fe", ":lua show_flutter_emulators()<CR>", { noremap = true, silent = true })

-- Clear search
vim.api.nvim_set_keymap("n", "<leader>cs", ":nohlsearch<CR>", {})




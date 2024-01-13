vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.mapleader = " "
vim.keymap.set("n", "<C-s>", ":w<CR>", {})
vim.keymap.set("n", "<C-a>", ":wa<CR>", {})
vim.keymap.set({ "n", "v", "i" }, "<F1>", ":set relativenumber<CR>", {})
vim.keymap.set({ "n", "v", "i" }, "<F2>", ":set norelativenumber<CR>", {})

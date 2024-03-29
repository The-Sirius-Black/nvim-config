local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

require("vim-options")

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("plugins.flutter.flutter")
require("plugins.cheatsheet.cheatsheet")
require("lazy").setup("plugins")

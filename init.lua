local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

require('vim-options')

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git', '--branch=stable', -- latest stable release
        lazypath
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')



local dap = require("dap")
dap.defaults.dart.exception_breakpoints = {"Error", "Exception"}


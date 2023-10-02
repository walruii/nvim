vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.termguicolors = true
vim.wo.wrap = false

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.cmd [[ set noswapfile ]]

--Line numbers
vim.wo.number = true
vim.opt.relativenumber = true

vim.opt.ignorecase = true
vim.opt.guicursor = ""

-- vim.g.hardtime_default_on = 1
-- vim.g.hardtime_motion_with_count_resets = 1
-- vim.g.hardtime_allow_different_key = 1
-- vim.g.hardtime_maxcount = 3

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', 'q:', '<Nop>')

-- vim.keymap.set('< mode >', '< keys >', ':call VSCodeNotify(" action ")<CR>')

vim.keymap.set('n', '<leader>h', ':nohl<CR>')

-- Move the pages
vim.keymap.set("n", "J", "10j")
vim.keymap.set("n", "K", "10k")

vim.keymap.set('n', '<leader>T', ':call VSCodeNotify("workbench.action.toggleActivityBarVisibility")<CR>')
vim.keymap.set('n', '<leader>t', ':call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>')
vim.keymap.set('n', '<leader>p', ':call VSCodeNotify("workbench.action.showCommands")<CR>')
vim.keymap.set('n', '<leader>f', ':call VSCodeNotify("workbench.action.quickOpen")<CR>')
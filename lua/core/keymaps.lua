-- Navigate vim panes better
--vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
--vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
--vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
--vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('n', '<F8>', ':!gcc % -o %<<CR>')
vim.keymap.set('n', '<F9>', ':!g++ % -o %<<CR>')
vim.keymap.set('i', 'jj', '<ESC>')
-- vim.keymap.set('t', '<C-w>', "<C-\\><C-n><C-w>h",{silent = true})

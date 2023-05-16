-- Navigate vim panes better
--vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
--vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
--vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
--vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('n', '<F8>', ':!gcc % -o %<<CR>')
vim.keymap.set('n', '<F9>', ':!g++ % -o %<<CR>')
-- vim.keymap.set('i', 'jj', '<ESC>')
-- vim.keymap.set('t', '<C-w>', "<C-\\><C-n><C-w>h",{silent = true})

-- move between windows
vim.keymap.set("n", "<C-k>", "<C-w>k", {})
vim.keymap.set("n", "<C-j>", "<C-w>j", {})
vim.keymap.set("n", "<C-h>", "<C-w>h", {})
vim.keymap.set("n", "<C-l>", "<C-w>l", {})

-- Buffer line
vim.keymap.set("n", "<leader>j", ":BufferLineCyclePrev<CR>", {})
vim.keymap.set("n", "<leader>k", ":BufferLineCycleNext<CR>", {})
vim.keymap.set("n", "<leader>J", ":BufferLineCloseLeft<CR>", {})
vim.keymap.set("n", "<leader>K", ":BufferLineCloseRight<CR>", {})
vim.keymap.set("n", "<leader>x", ":BufferLinePickClose<CR>", {})


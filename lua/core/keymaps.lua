vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('n', '<F8>', ':!gcc % -o %<<CR>')
vim.keymap.set('n', '<F9>', ':!g++ % -o %<<CR>')
-- vim.keymap.set('t', '<C-w>', "<C-\\><C-n><C-w>h",{silent = true})

-- move between windows
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", {})
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", {})

-- Buffer line
vim.keymap.set("n", "<leader>j", ":BufferLineCyclePrev<CR>", {})
vim.keymap.set("n", "<leader>k", ":BufferLineCycleNext<CR>", {})
vim.keymap.set("n", "<leader>J", ":BufferLineCloseLeft<CR>", {})
vim.keymap.set("n", "<leader>K", ":BufferLineCloseRight<CR>", {})
vim.keymap.set("n", "<leader>x", ":BufferLinePickClose<CR>", {})


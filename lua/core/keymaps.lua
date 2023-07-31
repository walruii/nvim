vim.keymap.set('n', '<F8>', ':!gcc % -o %<<CR>')
vim.keymap.set('n', '\\', ':!g++ % -o %<<CR>')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<space>p', '<nop>')
vim.keymap.set('n', 'q:', '<Nop>')
-- vim.keymap.set('t', '<C-w>', "<C-\\><C-n><C-w>h",{silent = true})


-- move between windows
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", {})
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", {})

-- Move the pages
vim.keymap.set("n", "J", "<C-d>")
vim.keymap.set("n", "K", "<C-u>")

-- Buffer line
-- vim.keymap.set("n", "<leader>h", ":BufferLineCyclePrev<CR>", {})
-- vim.keymap.set("n", "<leader>l", ":BufferLineCycleNext<CR>", {})
-- vim.keymap.set("n", "<leader>H", ":BufferLineCloseLeft<CR>", {})
-- vim.keymap.set("n", "<leader>L", ":BufferLineCloseRight<CR>", {})
-- vim.keymap.set("n", "<leader>x", ":BufferLinePickClose<CR>", {})

vim.keymap.set("n", "<leader>h", ":nohl<CR>", {silent = true})
vim.keymap.set("n", "<leader>y", "\"*y")
vim.keymap.set("v", "<leader>y", "\"*y")
vim.keymap.set("n", "<leader>p", "\"*p")

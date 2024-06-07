vim.keymap.set('n', '<F8>', ':!gcc % -o %<<CR>')
vim.keymap.set('n', '\\', ':!g++ -std=c++17 % -o %<<CR>')

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<space>p', '<nop>')
vim.keymap.set('n', 'q:', '<Nop>')

-- move between windows
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", {})
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", {})

-- Move the pages
vim.keymap.set("n", "J", "<C-d>")
vim.keymap.set("n", "K", "<C-u>")

-- Split windows
vim.keymap.set("n", "ss", ":split<CR>")
vim.keymap.set("n", "sv", ":vsplit<CR>")

-- system clipboard
vim.keymap.set("n", "<leader>h", ":nohl<CR>", { silent = true })
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>p", "\"+p")

-- rename
-- vim.keymap.set("n", "<leader>rn", ":IncRename ")
vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<space>p", "<nop>")
vim.keymap.set("n", "q:", "<Nop>")

-- Oil.nvim
vim.keymap.set("n", "<leader>t", ":Oil<CR>")
vim.keymap.set("n", "<leader>w", function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle line wrap" })

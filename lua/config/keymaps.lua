vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<space>p", "<nop>")
vim.keymap.set("n", "q:", "<Nop>")

-- move between windows
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", {})
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", {})

-- Move the pages
vim.keymap.set("n", "J", "<C-d>")
vim.keymap.set("n", "K", "<C-u>")

-- Remap for visual changes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "txt" },
	callback = function()
		local opts = { noremap = true, silent = true, buffer = true }
		vim.keymap.set({ "n", "v", "o" }, "j", "gj", opts)
		vim.keymap.set({ "n", "v", "o" }, "k", "gk", opts)
	end,
})

-- Split window
vim.keymap.set("n", "ss", ":split<CR>")
vim.keymap.set("n", "sv", ":vsplit<CR>")

-- system clipboard
vim.keymap.set("n", "<leader>h", ":nohl<CR>", { silent = true })
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>p", '"+p')

-- Oil.nvim
vim.keymap.set("n", "<leader>t", ":Oil<CR>")
vim.keymap.set("n", "<leader>w", function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle line wrap" })

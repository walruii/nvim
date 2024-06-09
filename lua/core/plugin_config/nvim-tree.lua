vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  view = {
    adaptive_size = false,
    width = 30,
    side = "right"
  }
})

vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>')

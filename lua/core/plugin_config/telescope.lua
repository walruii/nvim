require('telescope').setup {
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  },
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<Space><Space>', builtin.find_files, {})
vim.keymap.set('n', '<Space>o', builtin.oldfiles, {})
vim.keymap.set('n', '<Space>b', builtin.buffers, {})
vim.keymap.set('n', '<Space>eg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>eh', builtin.help_tags, {})
require("telescope").load_extension "file_browser"
vim.api.nvim_set_keymap(
  "n",
  "<space>/",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<space>.",
  ":Telescope file_browser<CR>",
  { noremap = true }
)

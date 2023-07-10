require('telescope').setup{ defaults = { file_ignore_patterns = {"node_modules"} } } 
local builtin = require('telescope.builtin')
require('telescope').load_extension('media_files')

vim.keymap.set('n', '<Space><Space>', builtin.find_files, {})
vim.keymap.set('n', '<Space>o', builtin.oldfiles, {})
vim.keymap.set('n', '<Space>b', builtin.buffers, {})
vim.keymap.set('n', '<Space>eg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>eh', builtin.help_tags, {})

local status, toggleterm = pcall(require, 'toggleterm')
if (not status) then return end

-- vim.cmd("let &shell = 'bash'")
-- vim.cmd("let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'")
-- vim.cmd("let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'")
-- vim.cmd("let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'")
-- vim.cmd("set shellquote= shellxquote=")

toggleterm.setup({
  size = 10,
  open_mapping = [[<C-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  close_on_exit = true,
  direction = 'float',
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal"
    }
  }
})

local Terminal = require('toggleterm.terminal').Terminal
local node = Terminal:new({ cmd = 'node', hidden = true })

function RUN_NODE()
  node:toggle()
end

vim.api.nvim_buf_set_keymap(0, 'n', ';n', '<Cmd>lua RUN_NODE()<CR>', {})

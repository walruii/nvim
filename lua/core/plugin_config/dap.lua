local dap, dapui = require("dap"), require("dapui")

require("dapui").setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
-- vim.keymap.set(n, '<leader>dk', function() require('dap').continue() end)
-- vim.keymap.set(n, '<leader>dl', function() require('dap').run_last() end)
-- vim.keymap.set(n, '<leader>b', function() require('dap').toggle_breakpoint() end)

-- dap.adapters.lldb = {
--     type = 'executable',
--     command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
--     env = {
--       LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
--     },
--     name = 'lldb'
-- }

-- dap.configurations.cpp = {
--     {
--         name = 'Launch lldb',
--         type = 'lldb',
--         request = 'launch',
--         program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--         end,
--         cwd = '${workspaceFolder}',
--         stopOnEntry = false,
--         args = {},
--         runInTerminal = true,
--     },
-- }
-- dap.configurations.c = dap.configurations.cpp

local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path().. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"


dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = codelldb_path,
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    runInTerminal = true,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

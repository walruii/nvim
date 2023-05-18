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

vim.keymap.set("n", "<leader>d<space>", ":DapContinue<CR>")
vim.keymap.set("n", "<leader>dl", ":DapStepInto<CR>")
vim.keymap.set("n", "<leader>dj", ":DapStepOver<CR>")
vim.keymap.set("n", "<leader>dh", ":DapStepOut<CR>")
vim.keymap.set("n", "<leader>dz", ":ZoomWinTabToggle<CR>")
vim.keymap.set(
                "n",
                "<leader>dgt",  -- dg as in debu[g] [t]race
                ":lua require('dap').set_log_level('TRACE')<CR>"
)
vim.keymap.set(
                "n",
                "<leader>dge",  -- dg as in debu[g] [e]dit
function()
    vim.cmd(":edit " .. vim.fn.stdpath('cache') .. "/dap.log")
end
)
vim.keymap.set("n", "<F1>", ":DapStepOut<CR>")
vim.keymap.set("n", "<F2>", ":DapStepOver<CR>")
vim.keymap.set("n", "<F3>", ":DapStepInto<CR>")
vim.keymap.set(
                "n",
                "<leader>d-",
function()
    require("dap").restart()
end
)
vim.keymap.set(
                "n",
                "<leader>d_",
function()
    require("dap").terminate()
    require("dapui").close()
end
)
vim.keymap.set(
		"n",
		"<leader>dd",
		function()
			require("dapui").open()  -- Requires nvim-dap-ui

			vim.cmd[[DapContinue]]  -- Important: This will lazy-load nvim-dap
		end
)

require "dapui".setup({
    -- icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    -- mappings = {
    --     -- Use a table to apply multiple mappings
    --     expand = { "<CR>", "<2-LeftMouse>" },
    --     open = "o",
    --     remove = "d",
    --     edit = "e",
    --     repl = "r",
    --     toggle = "t",
    -- },
    -- -- Expand lines larger than the window
    -- -- Requires >= 0.7
    -- expand_lines = vim.fn.has("nvim-0.7"),
    -- -- Layouts define sections of the screen to place windows.
    -- -- The position can be "left", "right", "top" or "bottom".
    -- -- The size specifies the height/width depending on position. It can be an Int
    -- -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- -- Elements are the elements shown in the layout (in order).
    -- -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    -- layouts = {
    --     {
    --         elements = {
    --             -- Elements can be strings or table with id and size keys.
    --             { id = "scopes", size = 0.25 },
    --             "breakpoints",
    --             "stacks",
    --             "watches",
    --         },
    --         size = 40, -- 40 columns
    --         position = "left",
    --     },
    --     {
    --         elements = {
    --             "repl",
    --             "console",
    --         },
    --         size = 0.25, -- 25% of total lines
    --         position = "bottom",
    --     },
    -- },
    -- floating = {
    --     max_height = nil, -- These can be integers or a float between 0 and 1.
    --     max_width = nil, -- Floats will be treated as percentage of your screen.
    --     border = "single", -- Border style. Can be "single", "double" or "rounded"
    --     mappings = {
    --         close = { "q", "<Esc>" },
    --     },
    -- },
    -- windows = { indent = 1 },
    -- render = {
    --     max_type_length = nil, -- Can be integer or nil.
    --     max_value_lines = 100, -- Can be integer or nil.
    -- }
})

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
    name = 'lldb'
}

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    },
}
dap.configurations.c = dap.configurations.cpp

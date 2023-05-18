require("mason").setup()
require("mason-nvim-dap").setup({
    ensure_installed = { "python", "c" }
})
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd" }
})

require("lspconfig").lua_ls.setup {}
require("lspconfig").clangd.setup {}


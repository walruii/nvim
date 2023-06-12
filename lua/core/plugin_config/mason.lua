require("mason").setup()
require("mason-nvim-dap").setup({
    ensure_installed = { "python", "c" }
})
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd", "cssls", "html", "tsserver", "cmake", "neocmake"}
})

require("lspconfig").lua_ls.setup {}
require("lspconfig").clangd.setup {}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- npm i -g vscode-langservers-extracted

require'lspconfig'.cssls.setup {
    capabilities = capabilities,
}

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

require'lspconfig'.tsserver.setup{}

require'lspconfig'.neocmake.setup{}

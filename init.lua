if vim.g.vscode then
    -- VSCode extension
    require("core.vscode.settings")
else
    require("core.options")
    require("core.keymaps")
    require("core.plugins")
    require("core.plugin_config")
end

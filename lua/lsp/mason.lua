local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
    return
end

-- enable mason
mason.setup()

mason_lspconfig.setup {
    -- list of servers for mason to install
    ensure_installed = {
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "emmet_ls",
        "volar",
    },
    automatic_installation = true,
}

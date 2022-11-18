local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
    return
end

local null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not null_ls_ok then
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
        "sumneko_lua",
        "emmet_ls",
        "volar",
    },
    automatic_installation = true,
}

mason_null_ls.setup {
    -- list of formatters & linters for mason to install
    ensure_installed = {
        "prettier", -- ts/js formatter
        "stylua", -- lua formatter
        "eslint_d", -- ts/js linter
    },
    -- auto-install configured formatters & linters (with null-ls)
    automatic_installation = true,
}

vim.cmd [[ 
    augroup vim_formatter
    autocmd!
    autocmd BufWritePost *.vim :normal gg=G
    augroup END
]]

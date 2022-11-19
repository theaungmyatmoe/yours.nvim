local null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not null_ls_ok then
    return
end

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
-- vim lang formater
vim.cmd [[ 
    augroup vim_lang_formatter
    autocmd!
    autocmd BufWritePost *.vim :normal gg=G
    augroup END
]]

-- Set up nvim-cmp.
local ok, cmp = pcall(require,'cmp')
if not ok then
    return 
end

local luasnip_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_ok then
    return
end

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        -- Specify a snippet engines to load in completion menu
        expand = function(args)
            luasnip.lsp_expand(args.body) 
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})


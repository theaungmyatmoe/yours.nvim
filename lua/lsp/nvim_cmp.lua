local ok, cmp = pcall(require, "cmp")
if not ok then
    return
end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
    return
end

local lspkind_ok, lspkind = pcall(require, "lspkind")
if not lspkind_ok then
    return
end

vim.opt.completeopt = "menu,menuone,noselect"

local format = lspkind.cmp_format({
    preset = "codicons",
    mode = "symbol_text",
    maxwidth = 50,
})

-- snippet lazy loading
require("luasnip.loaders.from_vscode").lazy_load()

-- check for supertab completion
local has_words_before = function()
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api
                .nvim_buf_get_lines(0, line - 1, line, true)[1]
                :sub(col, col)
                :match("%s")
            == nil
end

cmp.setup({
    view = {
        entries = { name = "custom", selection_order = "near_cursor" },
    },
    window = {
        completion = {
            -- border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
        },
        documentation = {},
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local original_kind = vim_item.kind
            local kind = format(entry, vim_item)

            -- Split the kind from lspkind into two parts so we can place the icon
            -- on the left and the text on the right. This allows for quick scanning
            -- on the left near the text while still providing the full completion
            -- information if needed.
            ---@diagnostic disable-next-line: param-type-mismatch
            local strings = vim.split(kind.kind, "%s", { trimempty = true })

            kind.kind = strings[1] .. " "
            kind.menu = "   " .. strings[2]

            -- Highlight the menu text the same as the kind icon
            kind.menu_hl_group = "CmpItemKind" .. original_kind

            return kind
        end,
    },
    snippet = {
        -- Specify a snippet engines to load in completion menu
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
})

local no_format = {
    fields = { "abbr" },
}

-- Use buffer source for '/'
cmp.setup.cmdline({ "/" }, {
    mapping = cmp.mapping.preset.cmdline(),
    formatting = no_format,
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    formatting = no_format,
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

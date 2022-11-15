local ok, toggle_term = pcall(require, "toggleterm")
if not ok then
    return
end

function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- ctrl + \ and ctrl + n to get back to normal mode form term mode
toggle_term.setup({
    width = 13,
    open_mapping = [[<C-\>]],
    direction = "horizontal", --"vertical" | "horizontal" | "tab" | "float",
    float_opts = {
        border = "curved",
    },
    start_in_insert = true,
    winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
            return term.name
        end,
    },
})

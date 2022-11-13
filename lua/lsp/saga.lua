local ok, saga = pcall(require, "lspsaga")

if not ok then
    return
end
saga.init_lsp_saga({
    border_style = "rounded",
    -- keybinds for navigation in lspsaga window
    move_in_saga = { prev = "<C-p>", next = "<C-n>" },
    -- use enter to open file with finder
    finder_action_keys = {
        open = "<CR>",
    },
    -- use enter to open file with definition preview
    definition_action_keys = {
        edit = "<CR>",
    },
})

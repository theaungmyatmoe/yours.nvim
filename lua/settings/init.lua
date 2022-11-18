_G.settings = {
    appearance = {
        -- NeoSolarized
        theme = "dracula",
        -- vim.cmd [[set guifont=JetBrainsMono\ Nerd\ Font:h12]]
        font = "JetbrainsMono Nerd Font",
        font_size = 14,
    },
    user_interface = {
        file_explorer = {
            float = true,
            position = "left",
            width = 30,
        },
        telescope = {
            dropdown = true,
            previewer = false,
        },
        tree_indent = {
            rainbow = false,
            whitespace = false,
            background_whitespace = false,
        },
        terminal = {
            float = false,
        },
    },
}

return settings

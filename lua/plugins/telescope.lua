local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

telescope.setup {
    defaults = {
        layout_config = {
            prompt_position = "top",
        },
        prompt_prefix = " ",
        selection_caret = "❯ ",
        path_display = { "truncate" },
        width = 0.87,
        height = 0.80,
        file_ignore_patterns = {
            "undo",
        },
        mappings = {},
    },
    pickers = {
        find_files = {
            theme = "dropdown",
            previewer = false,
            prompt_title = false,
        },
    },
    extensions = {},
}

telescope.load_extension "fzf"

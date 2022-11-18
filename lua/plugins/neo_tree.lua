local ok, neo_tree = pcall(require, "neo-tree")

if not ok then
    return
end

neo_tree.setup {
    close_if_last_window = false,
    enable_diagnostics = true,
    enable_git_status = true,
    popup_border_style = "rounded",
    sort_case_insensitive = false,
    default_component_configs = {
        indent = {
            indent_size = 2,
            padding = 0,
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            with_expanders = true,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            default = "",
            highlight = "NeoTreeFileIcon",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
        },
        git_status = {
            symbols = {
                added = "",
                deleted = "",
                modified = "",
                renamed = "",
                untracked = "★",
                ignored = "",
                unstaged = "✗",
                staged = "✓",
                conflict = "",
            },
        },
    },
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
        },
    },
    window = { width = 30 },
}

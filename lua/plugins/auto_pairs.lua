local ok, auto_pairs = pcall(require, "nvim-autopairs")

if not ok then
    return
end

auto_pairs.setup({
    ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
})

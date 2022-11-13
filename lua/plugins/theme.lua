local theme = settings.appearance.theme or "dracula"
local ok, _ = pcall(vim.cmd, string.format("colorscheme %s", theme))
if not ok then
    print(string.format("You %s is not installed.", theme))
end

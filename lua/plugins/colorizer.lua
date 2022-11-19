local ok, colorizer = pcall(require, "colorizer")

colorizer.setup {
    "css",
    "javascript",
    html = {
        mode = "foreground",
    },
}

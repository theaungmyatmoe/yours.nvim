local status, bufferline = pcall(require, "bufferline")
if not status then
    print "not working"
    return
end

bufferline.setup {}

-- prev and next
vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})

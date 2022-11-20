local ok, whichkey = pcall(require, "which-key")
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new {
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
        width = vim.o.columns - 6,
        height = vim.o.lines - 5,
    },
}
local float_term = Terminal:new { direction = "float" }

if not ok then
    return
end
local function float_term_toggle()
    return float_term:toggle()
end

local function _lazygit_toggle()
    lazygit:toggle()
end

local conf = {
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
    },
}

local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

local mappings = {
    e = {
        name = "File Explorer",
        e = { "<cmd>NeoTreeFloatToggle<CR>", "Float File Explorer" },
    },

    f = {
        name = "File Finder",
        f = { "<cmd>Telescope find_files<cr>", "Find Files" },
    },
    s = {
        name = "Search",
        s = { "<cmd>SearchBoxMatchAll<cr>", "Search Text" },
        r = { "<cmd>SearchBoxReplace<cr>", "Replace Text" },
    },
    t = {
        name = "Terminal",
        t = { "<cmd>ToggleTerm<cr>", "Integrated Terminal" },
        f = { float_term_toggle, "Float Terminal" },
    },
    l = { _lazygit_toggle, "Toggle Lazy Git" },
}

whichkey.setup(conf)
whichkey.register(mappings, opts)

local ok, whichkey = pcall(require, "which-key")
local Terminal = require("toggleterm.terminal").Terminal
local lazygit =
    Terminal:new { cmd = "lazygit", hidden = true, direction = "float" }
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
    ["q"] = { "<cmd>q!<cr>", "Quit" },
    f = {
        name = "File",
        f = { "<cmd>Telescope find_files<cr>", "Find Files" },
    },
    e = {
        name = "File Explorer",
        e = { "<cmd>NeoTreeFloatToggle<CR>", "Float File Explorer" },
    },
    t = {
        name = "Terminal",
        t = { "<cmd>ToggleTerm<cr>", "Integrated Terminal" },
        f = { float_term_toggle, "Float Terminal" },
        l = { _lazygit_toggle, "Toggle Lazy Git" },
    },
}

whichkey.setup(conf)
whichkey.register(mappings, opts)

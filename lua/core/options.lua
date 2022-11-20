vim.cmd [[
    filetype plugin indent on
    syntax on
]]

vim.opt.guifont = { "JetbrainsMono Nerd Font", ":h15" }

-- unload nvim default plugins
vim.opt.termguicolors = true
vim.g.loaded_gzip = false
vim.g.loaded_matchit = false
vim.g.loaded_netrwPlugin = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_zipPlugin = false
vim.g.loaded_man = false
vim.g.loaded_2html_plugin = false
vim.g.loaded_remote_plugins = false
vim.g.loaded_perl_provider = false
vim.g.loaded_ruby_provider = false

local opt = vim.opt

opt.timeoutlen = 300
opt.updatetime = 300 -- faster completion
opt.title = true -- set the title of window to the value of the titlestring
opt.titlestring = "%<%F - nvim" -- what the title of the window will be set to
opt.undofile = true -- enable persistent undo
opt.undodir = vim.fn.stdpath "config" .. "/undo"

-- line number
opt.number = true
opt.relativenumber = true

-- tabs and indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.swapfile = false

-- text wrap
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- hightligth active line
opt.cursorline = true

-- true color terminal settings
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes" -- enable specific highlights in debug mode

-- backspace settings
opt.backspace = "indent,eol,start"
-- enable native clipboard instead of vim default clipboard behavior
opt.clipboard:append "unnamedplus"

-- split windows
opt.splitright = true
opt.splitbelow = true

-- set dash as normal letter instead of divide behavior
opt.iskeyword:append "-"

opt.showmode = false

vim.g.mapleader = " " -- space for leader key

local keymap = vim.keymap

-- general keymaps

vim.cmd [[ 
nnoremap <C-q> :q!<CR>
nnoremap <C-w> :Bdelete<CR>
]]

keymap.set("n", "<C-s>", ":update<cr>", { silent = true, noremap = true })

keymap.set("n", "x", '"_x') -- backward delete
keymap.set("i", "<C-s>", ":w<CR>")
keymap.set("n", "<C-a>", "gg<S-v>G")

-- remove searched highlight
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single word without copying
keymap.set("n", "x", "_x")

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<A-Left>", ":bprevious<CR>") -- previous: buffer tab
keymap.set("n", "<A-Right>", ":bnext<CR>") -- next buffer

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- file browser
keymap.set("n", "<A-1>", ":NeoTreeFocusToggle<CR>", { silent = true })

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- trobule
keymap.set(
    "n",
    "<leader>xx",
    "<cmd>TroubleToggle<cr>",
    { silent = true, noremap = true }
)

-- search inside file
keymap.set("n", "<C-f>", "<cmd>SearchBoxMatchAll<cr>")

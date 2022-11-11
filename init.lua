require('settings')
require('plugins')
require('plugins.theme')
require('plugins.neo_tree')
require('plugins.buffer_line')
require('plugins.lualine')
require('plugins.telescope')
require('plugins.toggle_term')
require('plugins.auto_pairs')


require('core.options')
require('core.keymaps')

if vim.fn.has "nvim-0.8" ~= 1 or vim.version().prerelease then
    vim.schedule(function() vim.notify("Unsupported Neovim Version! Please check the requirements", "error") end)
end


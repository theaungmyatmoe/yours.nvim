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

require "settings"
require "core.options"
require "core.keymaps"
require "plugin_manager.packer"

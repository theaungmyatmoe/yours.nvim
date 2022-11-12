require("settings")
require("plugins.dashboard")
require("plugins.packer")
require("plugins.theme")
require("plugins.neo_tree")
require("plugins.buffer_line")
require("plugins.lualine")
require("plugins.telescope")
require("plugins.toggle_term")
require("plugins.auto_pairs")

require("lsp.lspconfig")
require("lsp.mason")
require("lsp.nvim_cmp")
require("lsp.saga")

require("formatters.null_ls")

require("core.options")
require("core.keymaps")

if vim.fn.has("nvim-0.8") ~= 1 or vim.version().prerelease then
	vim.schedule(function()
		vim.notify("Unsupported Neovim Version! Please check the requirements", "error")
	end)
end

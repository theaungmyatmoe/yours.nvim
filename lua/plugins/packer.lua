local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- auto command which reloads nvim and installs/updates/removes plugins when file is saved
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost packer.lua source <afile> | PackerSync
augroup end
]])

local ok, packer = pcall(require, "packer")
if not ok then
	return
end

return packer.startup(function(use)
	-- package manager
	use({
		"wbthomason/packer.nvim",
		config = {
			profile = {
				enable = true,
				threshold = 1, -- the amount in ms that a plugin's load time must be over for it to be included in the profile
			},
		},
	})

	-- [[ Dependencies for Most of the Packages written in Lua ]]
	use("nvim-lua/plenary.nvim")
	use("nvim-tree/nvim-web-devicons")
	use("MunifTanjim/nui.nvim")

	-- [[ User Interface  ]]
	use({ "dracula/vim", as = "dracula" })
	use({ "akinsho/bufferline.nvim", tag = "v3.*" })
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
	})
	use("nvim-lualine/lualine.nvim")
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "akinsho/toggleterm.nvim", tag = "*" })
	use({ "windwp/nvim-autopairs" })

	-- [[ Auto Completions ]]
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")

	use("rafamadriz/friendly-snippets")
	use("onsails/lspkind.nvim")
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		"jayp0521/mason-null-ls.nvim",
	})

	use({ "glepnir/dashboard-nvim" })

	-- bootstrap packer
	if packer_bootstrap then
		require("packer").sync()
	end
end)

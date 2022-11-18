local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath "data"
        .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system {
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        }
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- auto command which reloads nvim and installs/updates/removes plugins when file is saved
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost packer.lua source <afile> | PackerSync
augroup end
]]

local ok, packer = pcall(require, "packer")
if not ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}
return packer.startup(function(use)
    use { "lewis6991/impatient.nvim", config = [[require('impatient')]] }
    -- package manager
    use {
        "wbthomason/packer.nvim",
        config = {
            profile = {
                enable = true,
                threshold = 1, -- the amount in ms that a plugin's load time must be over for it to be included in the profile
            },
            git = {
                clone_timeout = 300,
                subcommands = {
                    update = "pull -ff-only --progress --rebase=true",
                },
            },
            auto_clean = true,
            compile_on_sync = true,
        },
    }

    -- [[ Dependencies for Most of the Packages written in Lua ]]
    use "nvim-lua/plenary.nvim"
    use { "kyazdani42/nvim-web-devicons" }
    use "MunifTanjim/nui.nvim"

    -- [[ User Interface  ]]

    use {
        "dracula/vim",
        as = "dracula",
        config = function()
            require "plugins.theme"
        end,
    }
    use {
        "akinsho/bufferline.nvim",
        tag = "v3.*",
        event = "BufWinEnter",
        config = function()
            require "plugins.buffer_line"
        end,
    }
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require "plugins.neo_tree"
        end,
    }
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        event = "BufWinEnter",
        config = function()
            require "plugins.lualine"
        end,
    }

    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    }
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        cmd = "Telescope",
        after = { "telescope-fzf-native.nvim" },
        config = function()
            require "plugins.telescope"
        end,
    }
    use {
        "akinsho/toggleterm.nvim",
        tag = "*",
    }
    -- [[ Auto Completions ]]
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    use {
        "hrsh7th/nvim-cmp",
        config = function()
            require "lsp.nvim_cmp"
        end,
    }

    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-buffer" }
    use { "hrsh7th/cmp-path" }
    use { "hrsh7th/cmp-cmdline" }
    use { "saadparwaiz1/cmp_luasnip" }
    use { "L3MON4D3/LuaSnip" }
    use { "hrsh7th/cmp-nvim-lua" }

    use {
        "rafamadriz/friendly-snippets",
        module = { "cmp", "cmp_nvim_lsp" },
        event = "InsertEnter",
    }
    use { "onsails/lspkind.nvim" }
    use {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require "lsp.saga"
        end,
    }
    use {
        "jose-elias-alvarez/null-ls.nvim",
        "jayp0521/mason-null-ls.nvim",
    }
    use {
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        config = function()
            require "plugins.auto_pairs"
        end,
    }

    use {
        "glepnir/dashboard-nvim",
        event = "BufWinEnter",
        config = function()
            require "plugins.dashboard"
        end,
    }

    use { "lukas-reineke/indent-blankline.nvim", event = "BufRead" }
    use { "norcalli/nvim-colorizer.lua", event = "BufRead" }
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require "plugins.gitsigns"
        end,
    }
    -- lua with packer.nvim
    use {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    }

    use {
        "folke/which-key.nvim",
    }
    use {
        "numToStr/Comment.nvim",
    }
    use "folke/lsp-colors.nvim"
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update =
                require("nvim-treesitter.install").update { with_sync = true }
            ts_update()
        end,
        config = function()
            require "plugins.tree_sitter"
        end,
    }

    use { "windwp/nvim-ts-autotag" }
    use { "p00f/nvim-ts-rainbow" }
    -- Lua
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
    }
    -- bootstrap packer
    if packer_bootstrap then
        packer.sync()
    end
end)

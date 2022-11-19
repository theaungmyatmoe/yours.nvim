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
    use {
        "lewis6991/impatient.nvim",
        config = function()
            require "impatient"
        end,
    }
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
        },
    }

    -- [[ general dependencies ]]
    use { "nvim-lua/plenary.nvim" }
    use { "MunifTanjim/nui.nvim" }
    use { "nvim-tree/nvim-web-devicons" }

    -- [[ theme ]]
    use {
        "dracula/vim",
        as = "dracula",
        config = function()
            require "plugins.theme"
        end,
    }

    -- [[ Integrated GUI Layer ]]
    -- Startup Dashboard, Key Menu, File Explorer, Tab Bar, Status Line, Terminal, Search Everywhere
    -- Problem Window
    -- Indent Guide, Git Integration

    use {
        "glepnir/dashboard-nvim",
        event = "BufWinEnter",
        cmd = { "Dashboard", "DashboardNewFile" },
        config = function()
            require "plugins.dashboard"
        end,
    }
    use {
        "folke/which-key.nvim",
        event = "BufWinEnter",
        config = function()
            require "plugins.which_key"
        end,
    }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        event = "BufWinEnter",
        requires = {
            { "nvim-lua/plenary.nvim", opt = true },
            { "kyazdani42/nvim-web-devicons", opt = true },
            { "MunifTanjim/nui.nvim", opt = true },
        },
        config = function()
            require "plugins.neo_tree"
        end,
    }

    use {
        "akinsho/bufferline.nvim",
        tag = "v3.*",
        requires = {
            { "nvim-tree/nvim-web-devicons", opt = true },
        },
        event = "BufWinEnter",
        config = function()
            require "plugins.buffer_line"
        end,
    }

    use {
        "akinsho/toggleterm.nvim",
        tag = "*",
        config = function()
            require "plugins.toggle_term"
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
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
            },
            { "nvim-lua/plenary.nvim" },
        },
        cmd = "Telescope",
        config = function()
            require "plugins.telescope"
        end,
    }

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

    use {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
    }

    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require "plugins.gitsigns"
        end,
    }

    -- [[ Code Editor ]]
    -- Bracket Pairs, Toggle Comment, Easy escape
    -- CSS Highlight
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        after = "nvim-cmp",
        config = function()
            require "plugins.auto_pairs"
        end,
    }
    use {
        "numToStr/Comment.nvim",
        config = function()
            require "plugins.comment"
        end,
    }
    use {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    }
    use {
        "norcalli/nvim-colorizer.lua",
        event = "BufRead",
    }

    -- [[ Better Syntax Analysis ]]
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
    use { "windwp/nvim-ts-autotag", after = "nvim-treesitter" }
    use { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" }

    -- [[ Language Server Protocol and Snippet Engine ]]
    use {
        "neovim/nvim-lspconfig",
        config = function()
            require "lsp.lspconfig"
        end,
    }
    use { "williamboman/mason.nvim" }
    use {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require "lsp.mason"
        end,
    }

    use {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter", -- this make disable icon color
        wants = { "LuaSnip" },
        requires = { --- Autocompletion
            { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
            { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
            { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
            { "hrsh7th/cmp-path", after = "nvim-cmp" },
            { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
            { "L3MON4D3/LuaSnip" },
        },
        config = function()
            require "lsp.nvim_cmp"
        end,
    }
    use { "hrsh7th/cmp-nvim-lsp" } -- builtin lsp complete

    -- vscode like auto complete
    use {
        "rafamadriz/friendly-snippets",
        module = { "cmp", "cmp_nvim_lsp" },
        event = "InsertEnter",
    }
    use { "onsails/lspkind.nvim" } -- icon inside autocomplete window
    use {
        "glepnir/lspsaga.nvim",
        branch = "main",
        event = "BufRead",
        config = function()
            require "lsp.saga"
        end,
    } -- better goto navigation
    use "folke/lsp-colors.nvim" -- customize lsp colors

    -- [[ Linter and Formatter ]]
    use {
        "jayp0521/mason-null-ls.nvim",
        config = function()
            require "formatters.mason_null_ls"
        end,
    } -- linter and formatter installer

    use {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require "formatters.null_ls"
        end,
    } -- formatter

    if packer_bootstrap then
        packer.sync()
    end
end)

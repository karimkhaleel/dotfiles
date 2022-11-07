return require('packer').startup(function(use)
    -- [[ Plugins go here ]]

    -- [[ Theme ]]
    use { "mhinz/vim-startify" }
    use { "DanilaMihailov/beacon.nvim" }
    use { "kyazdani42/nvim-web-devicons" }
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons",
            opt = true }
    }
    use {
        "JoosepAlviste/palenightfall.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    }
    -- [[ Dev ]]
    use {
        "williamboman/mason.nvim", -- lsp
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    }
    use { "jose-elias-alvarez/null-ls.nvim" } -- language server abstractions
    use { -- file explorer tab
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons"
    }
    use {
        "nvim-telescope/telescope.nvim", -- fuzzy finder
        requires = { { "nvim-lua/plenary.nvim" } }
    }
    use { -- debugger
        "mfussenegger/nvim-dap",
        opt = true,
        event = "BufReadPre",
        module = { "dap" },
        wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
        requires = {
            "Pocco81/DAPInstall.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "nvim-telescope/telescope-dap.nvim",
            { "leoluz/nvim-dap-go", module = "dap-go" },
            { "jbyuki/one-small-step-for-vimkind", module = "osv" },
        },
        config = function()
            require("config.dap").setup()
        end,
    }
    use { "majutsushi/tagbar" } -- code structure
    use { "Yggdroot/indentLine" } -- see indentation
    use { "tpope/vim-fugitive" } -- git integration
    use { "tpope/vim-rhubarb" } -- git browse integration
    use { "LinuxSuRen/fugitive-bitbucket.vim" } -- bitbucket integration
    use { "tpope/vim-surround" } -- surround with
    use { "junegunn/gv.vim" } -- commit history
    use { "windwp/nvim-autopairs" } -- auto close brackets, etc.
    use { "mbbill/undotree" } -- undo history
    use { "tpope/vim-commentary" } -- comment hotkey
    use { -- code highlighter
        "nvim-treesitter/nvim-treesitter",
        run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
    }
    use { "gennaro-tedesco/nvim-jqx" } -- json prettifier

    use { -- code navigation
        "phaazon/hop.nvim",
        branch = "v2"
    }

    use { -- autocomplete
        "ms-jpq/coq_nvim",
        branch = "coq"
    }
    use { -- autocomplete snippets
        "ms-jpq/coq.artifacts",
        branch = "artifacts",
        requires = { "ms-jpg/coq_nvim" }
    }
    use { -- autocomplete thirdparty tools
        "ms-jpq/coq.thirdparty",
        branch = "3p",
        requires = { "ms-jpg/coq_nvim" }

    }

    use { -- code problems tab
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons"
    }

    use { -- git blame
        "APZelos/blamer.nvim"
    }

    -- [[ Perf ]]
    use { "lewis6991/impatient.nvim" } -- speed up load time

end)

return require('packer').startup(function(use)
    -- [[ Plugins go here ]]
    
    -- [[ Theme ]]
    use { "mhinz/vim-startify" }
    use { "DanilaMihailov/beacon.nvim" }
    use {
        "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons",
        opt = true}
    }
    use { "JoosepAlviste/palenightfall.nvim" }
    -- [[ Dev ]]
    use {"neovim/nvim-lspconfig"}                   -- language servers
    use {                                           -- file explorer tab
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons"
    }
    use {
        "nvim-telescope/telescope.nvim",            -- fuzzy finder
        requires = { { "nvim-lua/plenary.nvim" } }
    }
    use { "majutsushi/tagbar" }                     -- code structure
    use { "Yggdroot/indentLine" }                   -- see indentation
    use { "tpope/vim-fugitive" }                    -- git integration
    use { "tpope/vim-surround" }                    -- surround with
    use { "junegunn/gv.vim" }                       -- commit history
    use { "windwp/nvim-autopairs" }                 -- auto close brackets, etc.
    use { "mbbill/undotree" }                       -- undo history
    use { "tpope/vim-commentary" }                  -- comment hotkey
    use {                                           -- code highlighter
        "nvim-treesitter/nvim-treesitter",
        run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
    }
    use { "gennaro-tedesco/nvim-jqx" }              -- json prettifier

    use {                                           -- code navigation
        "phaazon/hop.nvim",
        branch = "v2"
    }
    
    use {                                           -- autocomplete
        "ms-jpq/coq_nvim",
        branch = "coq"
    }
    use {                                           -- autocomplete snippets
        "ms-jpq/coq.artifacts",
        branch = "artifacts",
        requires = { "ms-jpg/coq_nvim" }
    }
    use {                                           -- autocomplete thirdparty tools
        "ms-jpq/coq.thirdparty",
        branch = "3p",
        requires = { "ms-jpg/coq_nvim" }

    }

    use {                                           -- code problems tab
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons"
    }

    use {                                           -- git blame
        "APZelos/blamer.nvim"
    }
    
    -- [[ Perf ]]
    use { "lewis6991/impatient.nvim" }              -- speed up load time

end)

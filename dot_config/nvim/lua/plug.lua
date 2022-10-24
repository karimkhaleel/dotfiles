return require('packer').startup(function(use)
    -- [[ Plugins go here ]]
    
    -- LSP
    use {"neovim/nvim-lspconfig"}

    use {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons"
    }

    -- [[ Theme ]]
    use { "mhinz/vim-startify" }
    use { "DanilaMihailov/beacon.nvim" }
    use {
        "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons",
                    opt = true}
    }
    use { "Mofiqul/dracula.nvim" }

    -- [[ Dev ]]
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
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
    }
    use { "gennaro-tedesco/nvim-jqx" }              -- json prettifier

    use {
        "phaazon/hop.nvim",                         -- code navigation
        branch = "v2"
    }
    
    use { 
        "ms-jpq/coq_nvim",                          -- autocomplete
        branch = "coq"
    }
    use { 
        "ms-jpq/coq.artifacts",                     -- autocomplete snippets
        branch = "artifacts",
        requires = { "ms-jpg/coq_nvim" }
    }
    use { 
        "ms-jpq/coq.thirdparty",                    -- autocomplete thirdparty tools
        branch = "3p",
        requires = { "ms-jpg/coq_nvim" }

    }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons"
    }
    -- [[ Perf ]]
    use { "lewis6991/impatient.nvim" }              -- speed up load time

end)

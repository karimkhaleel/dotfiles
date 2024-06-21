local overrides = require "configs.overrides"

return {
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {},
    lazy = false,
    branch = "regexp",
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>tvs", "<cmd>VenvSelect<cr>" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>tvc", "<cmd>VenvSelectCached<cr>" },
    },
  },

  {
    "chipsenkbeil/distant.nvim",
    event = "VeryLazy",
    branch = "v0.3",
    enabled = true,
    config = function()
      require("distant"):setup {
        servers = {
          ["*"] = {
            lsp = {
              ["proxidize"] = {
                cmd = "/home/proxidize/newproj/.venv/bin/pyright",
                root_dir = "/home/proxidize/newproj",
                file_types = { "python" },
              },
            },
          },
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-endwise",
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/playground",
    },
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    opts = overrides.nvimtree,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mapping = { "jk", "kj", "jj" },
      }
    end,
  },
}

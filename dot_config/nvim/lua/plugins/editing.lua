return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        keymaps = {
          visual = "<leader>Z",
        },
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    config = function()
      require("spectre").setup {
        default = {
          replace = {
            cmd = "oxi",
          },
        },
      }
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { "kkharji/sqlite.lua", module = "sqlite" },
      { "nvim-telescope/telescope.nvim" },
      { "ibhagwan/fzf-lua" },
    },
    config = function()
      require("neoclip").setup {
        enable_persistent_history = true,
        continuous_sync = true,
        on_select = {
          move_to_front = true,
          close_telescope = true,
        },
      }
      require("telescope").load_extension "neoclip"
    end,
  },
}

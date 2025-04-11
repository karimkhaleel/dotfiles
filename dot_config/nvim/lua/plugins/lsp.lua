return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.null-ls"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lsp_stuff"
    end,
  },

  {
    "b0o/schemastore.nvim",
    event = "VeryLazy",
  },
}

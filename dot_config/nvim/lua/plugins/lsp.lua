return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyrefly = {},
        ols = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
      },
    },
  },
}

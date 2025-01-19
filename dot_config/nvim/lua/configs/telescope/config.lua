local M = {
  "nvim-telescope/telescope.nvim",
  opts = {
    extensions_list = { "fzf" },
  },
}

require("configs.telescope.multigrep").setup()
return M

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = function(_, opts)
      local t = {
        extensions_list = { "fzf" },
        extensions = {
          ["ui-select"] = require("telescope.themes").get_dropdown {},
        },
      }
      return vim.tbl_deep_extend("force", opts, t)
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.load_extension "ui-select"
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension "import"
    end,
  },
}

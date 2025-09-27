return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local nvchad_config = require "nvchad.configs.telescope"

      local custom_config = {
        extensions_list = { "fzf", "import" },
      }

      return vim.tbl_deep_extend("force", nvchad_config, custom_config)
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
      telescope.load_extension "import"
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

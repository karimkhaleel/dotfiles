return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      table.insert(opts, 1, { extensions_list = { "fzf" } })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =   "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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

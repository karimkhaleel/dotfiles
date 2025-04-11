return {
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",

    config = function()
      require("diffview").setup {
        view = {
          merge_tool = {
            layout = "diff3_mixed",
            disable_diagnostics = true,
            winbar_info = true,
          },
        },
      }
    end,
  },
}

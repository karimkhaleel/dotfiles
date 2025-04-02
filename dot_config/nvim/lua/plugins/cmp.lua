return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "MattiasMTS/cmp-dbee",
        dependencies = {
          { "kndndrj/nvim-dbee" },
        },
        ft = "sql",
        opts = {},
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, 1, { name = "cmp-dbee" })
    end,
  },
}

local cmp = require "cmp"

local set_keybind = function(opts, keybind, action)
  opts.mapping[keybind] = action
end

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
      set_keybind(opts, "<c-l>", cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true })
      set_keybind(opts, "<c-k>", cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true })
      set_keybind(
        opts,
        "<c-l>",
        cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            require("luasnip").expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" })
      )
    end,
  },
}

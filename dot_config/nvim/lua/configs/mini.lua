local M = {
  function()
    local spec_treesitter = require("mini.ai").gen_spec.treesitter
    require("mini.ai").setup {
      custom_textobjects = {
        F = spec_treesitter {
          a = { "@conditional.outer", "@loop.outer" },
          i = { "@conditional.inner", "@loop.inner" },
        },
        h = spec_treesitter {
          a = { "@attribute.outer" },
          i = { "@attribute.inner" },
        },
      },
    }
  end,
  function()
    require("mini.files").setup()
  end,
}

return M

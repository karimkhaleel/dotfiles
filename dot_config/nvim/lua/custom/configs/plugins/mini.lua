local mini_module_configs = {
  function()
    local spec_treesitter = require("mini.ai").gen_spec.treesitter
    require("mini.ai").setup {
      custom_textobjects = {
        l = spec_treesitter {
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

local M = {
  "echasnovski/mini.nvim",
  version = false,
  enabled = true,
  event = "VeryLazy",
  config = function()
    for _, setup in ipairs(mini_module_configs) do
      setup()
    end
  end,
}

return M

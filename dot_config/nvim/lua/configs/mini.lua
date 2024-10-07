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
    require("mini.files").setup {
      content = {
        filter = function(name)
          local blocked =
            { ["__pycache__"] = true, ["venv"] = true, [".venv"] = true, [".pytest_cache"] = true, [".git"] = true }
          return not blocked[name.name]
        end,
      },
    }
  end,
}

return M

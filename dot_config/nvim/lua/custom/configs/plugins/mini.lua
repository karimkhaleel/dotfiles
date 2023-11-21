local mini_module_configs = {
  function()
    require("mini.ai").setup()
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

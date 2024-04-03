return {
  {
    "echasnovski/mini.nvim",
    version = false,
    enabled = true,
    event = "VeryLazy",
    config = function()
      local mini_module_configs = require "configs.mini"
      for _, setup in ipairs(mini_module_configs) do
        setup()
      end
    end,
  },
}

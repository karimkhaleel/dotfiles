---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "tokyonight",
  theme_toggle = { "tokyonight", "one_light" },
  transparency = false,

  tabufline = {
    --  more opts
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = {},
  },

  statusline = {
    --  more opts
    order = { "mode", "f", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    --  more modules
    modules = {
      f = function()
        local icon = "󰈚"
        local name = vim.fn.expand "%:p"

        if name ~= "Empty " then
          local devicons_present, devicons = pcall(require, "nvim-web-devicons")

          if devicons_present then
            local ft_icon = devicons.get_icon(name)
            icon = (ft_icon ~= nil and ft_icon) or icon
          end
        end

        return "%#St_file# " .. name
      end,
    },
  },
}

return M

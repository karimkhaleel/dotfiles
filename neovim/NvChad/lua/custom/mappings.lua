---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>qq"] = { ":q<enter>", "quit neovim", opts = { nowait = true } },
    ["<leader>ww"] = { ":w<enter>", "save", opts = { nowait = true } },
  },
}

-- more keybinds!

return M

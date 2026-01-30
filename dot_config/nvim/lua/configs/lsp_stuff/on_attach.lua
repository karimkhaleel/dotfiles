local on_attach = require("nvchad.configs.lspconfig").on_attach
local map = vim.keymap.set

local M = {}

M.on_attach = function(client, bufnr)
  on_attach(client, bufnr)

  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end


end

return M

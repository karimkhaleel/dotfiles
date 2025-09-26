local on_attach = require("nvchad.configs.lspconfig").on_attach
local map = vim.keymap.set
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local M = {}

M.on_attach = function(client, bufnr)
  on_attach(client, bufnr)

  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "<leader>ca", vim.lsp.buf.code_action, opts "Code actions")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")

  -- if the server supporst formatting then apply attempt to use it
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds {
      group = augroup,
      buffer = bufnr,
    }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        if require("flags").format_on_save then
          vim.lsp.buf.format { bufnr = bufnr, async = false }
        end
      end,
    })
  end
end

return M

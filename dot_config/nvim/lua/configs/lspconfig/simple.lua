local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
local on_attach = require "configs.lspconfig.on_attach"

local servers = {
  "ansiblels",
  "astro",
  "bashls",
  "cssls",
  "emmet_language_server",
  "nil_ls",
  "nimls",
  "sqlls",
  "svelte",
  "elixirls",
  "templ",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach.on_attach_custom,
    capabilities = capabilities,
  }
end

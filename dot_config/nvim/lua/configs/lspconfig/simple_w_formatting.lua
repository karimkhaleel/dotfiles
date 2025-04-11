local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
local on_attach = require "configs.lspconfig.on_attach"

local servers = {
  "clangd",
  "gleam",
  "rust_analyzer",
  "zls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach.on_attach_w_formatting,
    capabilities = capabilities,
  }
end

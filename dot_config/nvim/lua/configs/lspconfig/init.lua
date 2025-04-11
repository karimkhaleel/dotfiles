local on_attach = require "configs.lspconfig.on_attach"
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

lspconfig.jsonls.setup {
  on_attach = on_attach.on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}

lspconfig.htmx.setup {
  on_attach = on_attach.on_attach,
  capabilities = capabilities,
  filetypes = { "html", "htmldjango", "templ" },
}

lspconfig.html.setup {
  on_attach = on_attach.on_attach_w_formatting,
  capabilities = capabilities,
  filetypes = { "html", "htmldjango", "templ" },
}

lspconfig.denols.setup {
  on_attach = on_attach.on_attach_w_formatting,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.yamlls.setup {
  on_attach = on_attach.on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}

require "configs.lspconfig.simple"
require "configs.lspconfig.simple_w_formatting"
require "configs.lspconfig.go"
require "configs.lspconfig.python"

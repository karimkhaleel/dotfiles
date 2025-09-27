local on_attach = require "configs.lsp_stuff.on_attach"
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = {
  "ansiblels",
  "astro",
  "bashls",
  "cssls",
  "elixirls",
  "emmet_language_server",
  "nil_ls",
  "nimls",
  "sqlls",
  "svelte",
  "templ",
  "protols",
  "buf_ls",
  "gleam",
  "rust_analyzer",
  "tailwindcss",
  "zls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach.on_attach,
    capabilities = capabilities,
  }
end

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
  on_attach = on_attach.on_attach,
  capabilities = capabilities,
  filetypes = { "html", "htmldjango", "templ" },
}

lspconfig.denols.setup {
  on_attach = on_attach.on_attach,
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

require "configs.lsp_stuff.python"
require "configs.lsp_stuff.golang"

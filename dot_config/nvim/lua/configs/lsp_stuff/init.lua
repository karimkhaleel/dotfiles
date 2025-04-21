local on_attach = require "configs.lsp_stuff.on_attach"
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

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
    on_attach = on_attach.on_attach,
    capabilities = capabilities,
  }
end

local servers_w_formatting = {
  "clangd",
  "gleam",
  "rust_analyzer",
  "zls",
  "protols",
}

for _, lsp in ipairs(servers_w_formatting) do
  lspconfig[lsp].setup {
    on_attach = on_attach.on_attach_w_formatting,
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

require "configs.lsp_stuff.golang"
require "configs.lsp_stuff.python"

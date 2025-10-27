local on_attach = require "configs.lsp_stuff.on_attach"
local lsputil = require "utils.lsp"
local capabilities = require("nvchad.configs.lspconfig").capabilities

lsputil.config {
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
  jsonls = {
    on_attach = on_attach.on_attach,
    capabilities = capabilities,
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  htmx = {
    on_attach = on_attach.on_attach,
    capabilities = capabilities,
    filetypes = { "html", "htmldjango", "templ" },
  },
  html = {
    on_attach = on_attach.on_attach,
    capabilities = capabilities,
    filetypes = { "html", "htmldjango", "templ" },
  },
  yamlls = {
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
  },
}

require "configs.lsp_stuff.python"
require "configs.lsp_stuff.golang"

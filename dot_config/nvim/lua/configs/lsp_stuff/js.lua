local capabilities = require("nvchad.configs.lspconfig").capabilities
local on_attach = require "configs.lsp_stuff.on_attach"
local lsputil = require "utils.lsp"

local vue_language_server_path = vim.fn.stdpath "data"
  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
  enableForWorkspaceTypeScriptVersions = true,
}

lsputil.config {
  vtsls = {
    capabilities = capabilities,
    on_attach = on_attach.on_attach,
    filetypes = { "vue" },
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            vue_plugin,
          },
        },
      },
    },
  },
  "vue_ls",
}

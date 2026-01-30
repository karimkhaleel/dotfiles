local capabilities = require("nvchad.configs.lspconfig").capabilities
local on_attach = require "configs.lsp_stuff.on_attach"
local lsputil = require "utils.lsp"

local python_capabilities = {
  textDocument = {
    publishDiagnostics = {
      tagSupport = {
        valueSet = { 2 },
      },
    },
  },
}

lsputil.config {
  ruff = {
    on_attach = on_attach.on_attach_w_formatting,
    capabilities = capabilities,
  },
  ty = {
    settings = {
      ty = {
        disableLanguageServices = true,
      },
    },
  },
  basedpyright = {
    on_attach = on_attach.on_attach,
    capabilities = vim.tbl_deep_extend("force", capabilities, python_capabilities),
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          disableOrganizeImports = true,
          typeCheckingMode = "off",
        },
      },
    },
  },
}

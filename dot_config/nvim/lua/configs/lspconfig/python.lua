local lspconfig = require "lspconfig"
local capabilities = require("nvchad.configs.lspconfig").capabilities
local on_attach = require "configs.lspconfig.on_attach"

local python_capabilities = {
  textDocument = {
    publishDiagnostics = {
      tagSupport = {
        valueSet = { 2 },
      },
    },
  },
}

require("lspconfig").ruff.setup {
  on_attach = on_attach.on_attach_w_formatting,
  capabilities = capabilities,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = vim.tbl_deep_extend("force", capabilities, python_capabilities),
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
        disableOrganizeImports = true,
        typeCheckingMode = "off",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        stubPath = vim.fn.stdpath "data" .. "/lazy/python-type-stubs/stubs",
      },
    },
  },
}

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "astro",
  "clangd",
  "cssls",
  "emmet_language_server",
  "gopls",
  "html",
  "lua_ls",
  "nimls",
  "sqlls",
  "templ",
  "svelte",
  "tailwindcss",
  "zls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local python_capabilities = {
  textDocument = {
    publishDiagnostics = {
      tagSupport = {
        valueSet = { 2 },
      },
    },
  },
}

python_capabilities = vim.tbl_deep_extend("force", capabilities, python_capabilities)

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = python_capabilities,
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

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

local on_attach_rs = function(client, bufnr)
  local utils = require "core.utils"
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end
end

lspconfig.rust_analyzer.setup {
  on_attach = on_attach_rs,
}

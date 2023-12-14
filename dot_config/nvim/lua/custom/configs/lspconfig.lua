local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

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
  "pyright",
  "rust_analyzer",
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

--
lspconfig.pyright.setup {
  on_attach = on_attach,
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

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
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

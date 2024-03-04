local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- if you just want default config for the servers then put them in a table
local servers = {
  "astro",
  "clangd",
  "cssls",
  "emmet_language_server",
  "gopls",
  "nimls",
  "sqlls",
  "templ",
  "svelte",
  "tailwindcss",
  "zls",
  "ruff_lsp",
  "bashls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}

lspconfig.htmx.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "htmldjango", "templ" },
}

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "htmldjango", "templ" },
}

lspconfig.yamlls.setup {
  on_attach = on_attach,
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

local on_attach_rs = function(client, bufnr)
  local utils = require "core.utils"
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds {
      group = augroup,
      buffer = bufnr,
    }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        if require("custom.flags").format_on_save then
          vim.lsp.buf.format { bufnr = bufnr }
        end
      end,
    })
  end
end

lspconfig.rust_analyzer.setup {
  on_attach = on_attach_rs,
  capabilities = capabilities,
}

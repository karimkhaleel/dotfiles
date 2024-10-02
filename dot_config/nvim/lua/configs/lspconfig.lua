local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach_formatting = function(client, bufnr)
  on_attach(client, bufnr)

  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds {
      group = augroup,
      buffer = bufnr,
    }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        if require("flags").format_on_save then
          vim.lsp.buf.format { bufnr = bufnr }
        end
      end,
    })
  end
end

-- if you just want default config for the servers then put them in a table
local servers = {
  "ansiblels",
  "astro",
  "bashls",
  "cssls",
  "emmet_language_server",
  "gleam",
  "gopls",
  "nil_ls",
  "nimls",
  "pyright",
  "sqlls",
  "svelte",
  "tailwindcss",
  "templ",
}

local servers_w_formatting = {
  "clangd",
  "taplo",
  "rust_analyzer",
  "zls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

for _, lsp in ipairs(servers_w_formatting) do
  lspconfig[lsp].setup {
    on_attach = on_attach_formatting,
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

local on_attach_ruff = function(client, bufnr)
  on_attach(client, bufnr)

  -- Disable hover in favor of Pyright
  client.server_capabilities.hoverProvider = false

  local ruff_lsp_client = require("lspconfig.util").get_active_client_by_name(bufnr, "ruff_lsp")

  local request = function(method, params)
    ruff_lsp_client.request(method, params, nil, bufnr)
  end

  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds {
      group = augroup,
      buffer = bufnr,
    }

    local organize_imports = function()
      request("workspace/executeCommand", {
        command = "ruff.applyOrganizeImports",
        arguments = {
          { uri = vim.uri_from_bufnr(bufnr) },
        },
      })
    end

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        if require("flags").format_on_save then
          vim.lsp.buf.format { bufnr = bufnr }
          organize_imports()
        end
      end,
    })
  end
end

lspconfig.ruff_lsp.setup {
  on_attach = on_attach_ruff,
  capabilities = capabilities,
}

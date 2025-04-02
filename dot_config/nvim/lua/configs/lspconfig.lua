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
          vim.lsp.buf.format { bufnr = bufnr, async = true }
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
  "nil_ls",
  "nimls",
  "pyright",
  "sqlls",
  "svelte",
  "elixirls",
  "templ",
}

local servers_w_formatting = {
  "clangd",
  "gleam",
  "rust_analyzer",
  "taplo",
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
  on_attach = on_attach_formatting,
  capabilities = capabilities,
  filetypes = { "html", "htmldjango", "templ" },
}

local gofumpt_enabled = true

function ToggleGofumpt()
  gofumpt_enabled = not gofumpt_enabled

  -- Get the current gopls client
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    if client.name == "gopls" then
      -- Notify gopls to use new settings
      client.config.settings.gopls.gofumpt = gofumpt_enabled
      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })

      -- Optionally restart the client to ensure changes take effect
      vim.cmd "LspRestart gopls"
      print("gofumpt is now " .. (gofumpt_enabled and "enabled" or "disabled"))
      return
    end
  end

  print "gopls not found"
end

lspconfig.gopls.setup {
  on_attach = function(client, bufnr)
    on_attach_formatting(client, bufnr)

    local map = vim.keymap.set
    local autocmd = vim.api.nvim_create_autocmd

    map("n", "<leader>ts", ":lua ToggleGofumpt()<CR>", { desc = "toggle between gofumpt and gofmt" })

    autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        -- buf_request_sync defaults to a 1000ms timeout. Depending on your
        -- machine and codebase, you may want longer. Add an additional
        -- argument after params if you find that you have to write the file
        -- twice for changes to be saved.
        -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
        for cid, res in pairs(result or {}) do
          for _, r in pairs(res.result or {}) do
            if r.edit then
              local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
              vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
          end
        end
        vim.lsp.buf.format { async = false }
      end,
    })
  end,
  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
}

lspconfig.denols.setup {
  on_attach = on_attach_formatting,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
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

require("lspconfig").ruff.setup {}

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

local lspconfig = require "lspconfig"
local capabilities = require("nvchad.configs.lspconfig").capabilities
local on_attach = require "configs.lspconfig.on_attach"

local gofumpt_enabled = true

function ToggleGofumpt()
  gofumpt_enabled = not gofumpt_enabled

  -- Get the current gopls client
  local clients = vim.lsp.get_clients()
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
    on_attach.on_attach_formatting(client, bufnr)

    local map = vim.keymap.set
    local autocmd = vim.api.nvim_create_autocmd

    map("n", "<leader>ts", ":lua ToggleGofumpt()<CR>", { desc = "toggle between gofumpt and gofmt" })

    autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        local params = vim.lsp.util.make_range_params(0, "utf-8")
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

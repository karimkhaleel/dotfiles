local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require "null-ls"

local opts = {
  sources = {
    -- lua
    null_ls.builtins.formatting.stylua,

    -- js stuff
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.prettier.with {
      extra_filetypes = { "astro", "svelte" },
    },

    -- python sfuff
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    -- null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.diagnostics.mypy.with { command = { "python", "-m", "mypy" } },

    -- go stuff
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.diagnostics.golangci_lint,

    -- nim stuff
    null_ls.builtins.formatting.nimpretty,
  },

  on_attach = function(client, bufnr)
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
  end,
}

return opts

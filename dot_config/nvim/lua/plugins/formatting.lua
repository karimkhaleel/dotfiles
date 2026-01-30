return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },

      -- Bython
      python = {
        "ruff_fix",
        "ruff_format",
        "ruff_organize_imports",
      },

      -- Go
      go = { "gofumpt" },

      -- Rust
      rust = { "rustfmt" },

      -- Zig
      zig = { "zigfmt" },

      -- Web stuph
      javascript = { "prettier" },
      javascriptreact = { "prettier", "rustywind" },
      typescript = { "prettier" },
      typescriptreact = { "prettier", "rustywind" },
      vue = { "prettier", "rustywind" },
      svelte = { "prettier", "rustywind" },
      json = { "prettier" },
      jsonc = { "prettier" },
      markdown = { "prettier" },
      html = { "prettier", "rustywind" },
      css = { "prettier" },
      scss = { "prettier" },

      -- Misc
      toml = function(bufnr)
        if vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t") == "pyproject.toml" then
          return { "pyproject-fmt" }
        end
        return { "taplo" }
      end,
      yaml = { "prettier" },
      sql = { "sqruff" },
      nix = { "nixfmt" },
      sh = { "shfmt" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require "null-ls"

local h = require "null-ls.helpers"
local methods = require "null-ls.methods"

local FORMATTING = methods.internal.FORMATTING

local templ_fmt = h.make_builtin {
  name = "templ_fmt",
  meta = {
    url = "templ.guide",
    description = "Format templ",
  },
  method = FORMATTING,
  filetypes = { "templ" },
  generator_opts = {
    command = "/home/karim/.local/share/nvim/mason/bin/templ",
    args = {
      "fmt",
      "$FILENAME",
    },
    to_temp_file = true,
  },
  factory = h.formatter_factory,
}

--
local opts = {
  sources = {
    -- lua
    null_ls.builtins.formatting.stylua,

    -- js stuff
    null_ls.builtins.formatting.prettier.with {
      extra_filetypes = { "astro", "svelte" },
    },

    -- python sfuff
    null_ls.builtins.formatting.djlint.with {
      extra_args = { "--format-css", "--format-js" },
    },
    null_ls.builtins.diagnostics.djlint,

    null_ls.builtins.diagnostics.mypy,

    -- C/C++ stuff
    null_ls.builtins.formatting.clang_format,

    -- go stuff
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.diagnostics.golangci_lint,
    templ_fmt,

    -- nim stuff
    null_ls.builtins.formatting.nimpretty,

    -- sql stuff
    null_ls.builtins.diagnostics.sqlfluff,
    null_ls.builtins.formatting.sqlfluff,

    null_ls.builtins.formatting.shfmt,
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
          if require("flags").format_on_save then
            vim.lsp.buf.format { bufnr = bufnr }
          end
        end,
      })
    end
  end,
}

return opts

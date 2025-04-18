local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require "null-ls"

local h = require "null-ls.helpers"
local methods = require "null-ls.methods"
local utils = require "utils"

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

local opts = {
  sources = {
    -- lua
    null_ls.builtins.formatting.stylua,

    -- python sfuff
    null_ls.builtins.formatting.djlint.with {
      extra_args = { "--format-css", "--format-js" },
    },
    null_ls.builtins.diagnostics.djlint,

    null_ls.builtins.diagnostics.mypy.with {
      command = utils.first_nonempty(
        vim.loop.os_getenv "MYPYPATH",
        utils.capture_command_output "uv run which mypy",
        utils.get_executable_path("mypy", "mypy")
      ),
      extra_args = utils.parse_arg_string(vim.loop.os_getenv "MYPYARGS" or ""),
    },

    -- go stuff
    null_ls.builtins.diagnostics.golangci_lint,
    templ_fmt,

    -- nim stuff
    null_ls.builtins.formatting.nimpretty,

    -- js/ts
    null_ls.builtins.formatting.prettier,

    -- misc
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.nixpkgs_fmt,
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.sqruff,
    null_ls.builtins.formatting.sqruff,
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

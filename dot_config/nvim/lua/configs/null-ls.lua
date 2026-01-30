local null_ls = require "null-ls"

local opts = {
  sources = {
    -- python sfuff
    null_ls.builtins.diagnostics.djlint,

    -- go stuff
    null_ls.builtins.diagnostics.golangci_lint,

    -- misc
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.sqruff,
  },
}

return opts

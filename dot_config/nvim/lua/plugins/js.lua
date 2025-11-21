local M = {
  "pmizio/typescript-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
  },
  event = "VeryLazy",
  opts = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      vim.keymap.set("n", "gD", "<Cmd>TSToolsGoToSourceDefinition<CR>", { buffer = bufnr, desc = "Source Definition" })

      vim.keymap.set(
        "n",
        "<localleader>i",
        "<Cmd>TSToolsAddMissingImports<CR>",
        { buffer = bufnr, desc = "Add missing imports" }
      )
      vim.keymap.set(
        "n",
        "<localleader>o",
        "<Cmd>TSToolsOrganizeImports<CR>",
        { buffer = bufnr, desc = "Organize imports" }
      )
      vim.keymap.set(
        "n",
        "<localleader>r",
        "<Cmd>TSToolsRemoveUnused<CR>",
        { buffer = bufnr, desc = "Remove unused variables" }
      )
      vim.keymap.set("n", "<localleader>F", "<Cmd>TSToolsFixAll<CR>", { buffer = bufnr, desc = "Fix all" })
    end,
  },
  settings = {
    tsserver_file_preferences = {
      importModuleSpecifierPreference = "non-relative",

      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },
}

return M

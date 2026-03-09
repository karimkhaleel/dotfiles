return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
                disableOrganizeImports = true,
              },
            },
          },
        },
        ty = {
          settings = {
            ty = {
              disableLanguageServices = true,
            },
          },
        },
      },
    },
  },
}

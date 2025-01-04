return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.null-ls"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "b0o/schemastore.nvim",
    event = "VeryLazy",
  },

  {
    "pmizio/typescript-tools.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", "kyoh86/climbdir.nvim" },
    lazy = false,
    config = function()
      require("typescript-tools").setup {
        on_attach = function(client)
          -- Disable document formatting capabilities
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        root_dir = function(path)
          local marker = require "climbdir.marker"
          -- Determine the root directory based on the presence of package.json or node_modules
          return require("climbdir").climb(
            path,
            marker.one_of(marker.has_readable_file "package.json", marker.has_directory "node_modules"),
            {
              -- Stop the plugin if any of the specified files/folders are found
              halt = marker.one_of(
                marker.has_readable_file "deno.json",
                marker.has_readable_file "deno.jsonc",
                marker.has_readable_file "import_map.json",
                marker.has_directory "denops"
              ),
            }
          )
        end,
        single_file_support = false,
      }
    end,
  },

  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}

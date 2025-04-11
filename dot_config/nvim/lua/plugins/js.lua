local setup_debugging = function()
  local dap = require "dap"
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = 8123,
    executable = {
      command = "js-debug-adapter",
    },
  }

  for _, language in ipairs { "typescript", "javascript" } do
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        runtimeExecutables = "node",
      },
    }
  end
end

return {
  {
    "pmizio/typescript-tools.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", "kyoh86/climbdir.nvim" },
    lazy = false,
    config = function()
      setup_debugging()
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
}

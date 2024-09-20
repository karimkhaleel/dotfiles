---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "decay",
}

M.ui = {
  telescope = { style = "borderless" }, -- borderless / bordered

  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "round",
    order = nil,
    modules = nil,
  },
}

M.mason = {
  pkgs = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "astro-language-server",
    "css-lsp",
    "deno",
    "emmet-language-server",
    "eslint_d",
    "html-lsp",
    "js-debug-adapter",
    "prettier",
    "rustywind",
    "svelte-language-server",
    "tailwindcss-language-server",
    "typescript-language-server",
    "htmx-lsp",

    -- c/cpp stuff
    "clangd",
    "codelldb",

    -- python
    "debugpy",
    "djlint",
    "isort",
    "mypy",
    "pyright",
    "ruff-lsp",

    -- go
    "gofumpt",
    "golangci-lint",
    "gopls",
    "templ",

    -- rust
    "rust-analyzer",

    -- sql
    "sqlls",

    -- zig
    "zls",

    -- misc
    "ansible-language-server",
    "ansible-lint",
    "bash-language-server",
    "json-lsp",
    "nil",
    "nixpkgs-fmt",
    "shfmt",
    "taplo",
    "yaml-language-server",
  },
}

return M

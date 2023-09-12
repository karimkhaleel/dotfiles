local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "python",
    "svelte",
    "astro",
  },
  indent = {
    enable = true,
    disable = {
      "python",
    },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "eslint-lsp",
    "typescript-language-server",
    "svelte-language-server",
    "astro-language-server",
    "deno",
    "prettier",
    "js-debug-adapter",
    "rustywind",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- python
    "pyright",
    "black",
    "isort",
    "ruff",
    "mypy",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = false,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M

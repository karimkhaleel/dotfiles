local M = {}

M.treesitter = {
  sync_install = false,
  ensure_installed = {
    "astro",
    "bash",
    "c",
    "css",
    "dockerfile",
    "go",
    "html",
    "javascript",
    "json",
    "latex",
    "lua",
    "markdown",
    "markdown_inline",
    "nim",
    "org",
    "python",
    "query",
    "regex",
    "rust",
    "sql",
    "svelte",
    "templ",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml",
    "zig",
  },
  highlight = { enable = true, additional_vim_regex_highlighting = { "org", "markdown" } },
  indent = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = false },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<cr>",
      node_incremental = "<cr>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["aa"] = "@parameter.outer",
        ["aF"] = "@lawl",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
    },
    move = {
      enable = false,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
  matchup = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
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
    "ansible_language_server",
    "ansible_lint",
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

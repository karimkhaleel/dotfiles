local M = {}

M.treesitter = {
  sync_install = false,
  ensure_installed = {
    "bash",
    "dockerfile",
    "org",
    "query",
    "regex",
    "latex",
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
    "go",
    "nim",
    "rust",
    "sql",
  },
  highlight = { enable = true, additional_vim_regex_highlighting = { "org", "markdown" } },
  indent = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = false },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<cr>",
      node_incremental = "<C-]>",
      scope_incremental = "grn",
      node_decremental = "<C-[>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
    },
    move = {
      enable = true,
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
    swap = {
      enable = true,
      swap_next = swap_next,
      swap_previous = swap_prev,
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
    "css-lsp",
    "html-lsp",
    "eslint_d",
    "typescript-language-server",
    "svelte-language-server",
    "astro-language-server",
    "tailwindcss-language-server",
    "emmet-language-server",
    "deno",
    "prettier",
    "js-debug-adapter",
    "rustywind",

    -- c/cpp stuff
    "clangd",
    "clang-format",
    "codelldb",

    -- python
    "pyright",
    "black",
    "isort",
    "ruff",
    "flake8",
    "mypy",
    "debugpy",

    -- go
    "gopls",
    "gofumpt",
    "golangci_lint",

    -- rust
    "rust-analyzer",

    --sql
    "sqlls",
    "sqlfluff,",
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

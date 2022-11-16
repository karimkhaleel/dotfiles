-- LEADER
-- Need to be defined first in order not to defaul tot "\"
vim.g.mapleader = " "
vim.g.localleader = "\\"

-- IMPORTS
require('vars') -- Variables
require('opts') -- Options
require('keys') -- Keymaps
require('plug') -- Plugins
local servers = require('srv') -- LSP servers
-- PLUGINS

-- Completion
require "config.coq_config"
local coq = require "coq"
require("coq_3p") {
    src = "nvimlua",
    short_name = "nLUA",
}

-- LSP
local lspconfig = require "lspconfig"
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua", "tsserver", "pylsp", "html", "jsonls", "marksman", "sqlls", "taplo",
        "volar" }
})

require "mason-lspconfig".setup_handlers {
    function(server_name)
        lspconfig[server_name].setup {}
        lspconfig[server_name].setup { coq.lsp_ensure_capabilities {} }
    end,
    ["pylsp"] = function()
        lspconfig.pylsp.setup {
            settings = {
                pylsp = {
                    plugins = {
                        autopep8 = { enabled = false },
                        pycodestyle = { enabled = false },
                        pyflakes = { enabled = false },
                        yapf = { enabled = false }
                    }
                }
            }
        }
        -- lspconfig.pylsp.setup { coq.lsp_ensure_capabilities {} }
    end
}

local null_ls = require("null-ls")

-- code action sources
local code_actions = null_ls.builtins.code_actions

-- diagnostic sources
local diagnostics = null_ls.builtins.diagnostics

-- formatting sources
local formatting = null_ls.builtins.formatting

-- hover sources
local hover = null_ls.builtins.hover

-- completion sources
local completion = null_ls.builtins.completion

null_ls.setup({
    sources = {
        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.mypy.with({
            prefer_local = "$VIRTUAL_ENV/bin"
        }),
        -- JavaScript
        null_ls.builtins.code_actions.eslint
    }
})


-- Other

require("nvim-tree").setup {}
require("lualine").setup {
    options = {
        theme = require "lualine.themes.tokyonight"
    }
}
require("bufferline").setup {}
require("nvim-autopairs").setup {}
require("impatient")

-- Syntax highlight
require 'nvim-treesitter.configs'.setup {
    -- A list of parser names
    ensure_installed = { "c", "python", "lua", "javascript" },

    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
        -- `false` will enable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting of `tex` files, then you need to include `latex` in this list as this
        -- is the name of the parser)
        -- list of languages that will be disabled
        -- disable = {"rust"},

        -- setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },

    indent = {
        enable = true
    },
}

require "hop".setup {}
require "trouble".setup {}

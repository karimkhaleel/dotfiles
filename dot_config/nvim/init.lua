-- LEADER
-- Need to be defined first in order not to defaul tot "\"
vim.g.mapleader = ","
vim.g.localleader = "\\"

-- IMPORTS
require('vars')                    -- Variables
require('opts')                    -- Options
require('keys')                    -- Keymaps
require('plug')                    -- Plugins
local servers = require('srv')     -- LSP servers
-- PLUGINS

-- Completion

vim.g.coq_settings = {
  auto_start = 'shut-up',
  clients = {
    tmux = { enabled = false },
  },
}

coq = require"coq"

require("coq_3p") {
    src = "nvimlua",
    short_name = "nLUA",
}

-- LSP

local lsp = require"lspconfig"

for server, config in pairs(servers) do
    if type(config) == 'function' then
        config = config()
    end
    config.capabilities = vim.tbl_deep_extend(
        'keep',
        config.capabilities or {},
        client_capabilities or {}
    )
    lsp[server].setup(config)
    lsp[server].setup(coq.lsp_ensure_capabilities(config))
end


-- Other

require("nvim-tree").setup{}
require("lualine").setup {
    options = {
        theme = "dracula-nvim"
    }
}
require("nvim-autopairs").setup{}
require("impatient")

-- Syntax highlight
require'nvim-treesitter.configs'.setup{
    -- A list of parser names
    ensure_installed = {"c", "python", "lua", "javascript"},

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


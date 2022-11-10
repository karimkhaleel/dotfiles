local opt = vim.opt
local cmd = vim.api.nvim_command
local acmd = vim.api.nvim_create_autocmd

-- [[ Context ]]
opt.number = true                                   -- bool: Show line numbers
opt.relativenumber = true                           -- bool: Show relative line numbers
opt.scrolloff = 4                                   -- int:  Min num lines of context
opt.signcolumn = "yes"                              -- str:  Show the sign column

-- [[ Filetypes ]]
opt.encoding = "utf8"                               -- str:  String encoding to use
opt.fileencoding = "utf8"                           -- str:  File encoding to use

-- [[ Theme ]]
opt.syntax = "ON"                                   -- str:  Allow syntax highlighting
opt.termguicolors = true                            -- bool: If term supports ui color then enable
cmd("colorscheme tokyonight")

-- [[ Whitespace ]]
opt.expandtab = true                                -- bool: Use spaces instead of tabs
opt.shiftwidth = 4                                  -- num:  Size of an indent
opt.softtabstop = 4                                 -- num:  Number of spaces tabes count for in insert mode
opt.tabstop = 4                                     -- num:  Number of spaces tabs count for

-- [[ Splits ]]
opt.splitright = true                               -- bool: NPlace new window to the right of current one
opt.splitbelow = true                               -- bool: Place new window below the current one

-- [[ LSP ]]
vim.diagnostic.config({virtual_text = false})       -- bool: Stop showing virtual LSP diagnostic text

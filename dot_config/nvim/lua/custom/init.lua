-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
require "custom.configs.autocommands"

local opt = vim.opt

opt.relativenumber = true

-- fold settings
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- additional filetypes
vim.filetype.add {
  extension = {
    templ = "templ",
  },
}

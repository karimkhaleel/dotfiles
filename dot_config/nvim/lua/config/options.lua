-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false
vim.g.lazyvim_python_lsp = "pyrefly"

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local opencode_cmd = "opencode --port"
---@type snacks.terminal.Opts
local snacks_terminal_opts = {
  win = {
    position = "right",
    enter = false,
    on_win = function(win)
      -- Set up keymaps and cleanup for an arbitrary terminal
      require("opencode.terminal").setup(win.win)
    end,
  },
}
---@type opencode.Opts
vim.g.opencode_opts = {
  server = {
    start = function()
      require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
    end,
    stop = function()
      require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts):close()
    end,
    toggle = function()
      require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
    end,
  },
}

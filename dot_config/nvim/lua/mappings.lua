require "nvchad.mappings"
---@type MappingsTable
local M = {}

local copilot_on = true

local map = vim.keymap.set

-- General
map("n", ";", ":", { desc = "enter command mode", nowait = true })
map(
  "n",
  "<leader>tf",
  ":lua require('flags').toggle_format_on_save()<CR>",
  { desc = "toggle format on save", nowait = true }
)
map("n", "<leader>ti", ":lua require('flags').toggle_inlay_hints()<CR>", { desc = "toggle inlay hints", nowait = true })
map("n", "n", "nzzzv", { desc = "next search result centered" })
map("n", "N", "Nzzzv", { desc = "previous search result centered" })
map("n", "g,", "g,zvzz", { desc = "next change centered" })
map("n", "g;", "g;zvzz", { desc = "previous change centered" })
map("n", "<C-d>", "<C-d>zz", { desc = "page down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "page up centered" })
map("n", "<C-o>", "<C-o>zz", { desc = "jump back centered" })

-- Disabled mappings
map("n", "<tab>", "", { desc = "Disabled mapping" })
map("n", "<S-tab>", "", { desc = "Disabled mapping" })

-- Tabufline mappings
map("n", "<leader>k", function()
  require("nvchad.tabufline").next()
end, { desc = "Goto next buffer" })
map("n", "<leader>j", function()
  require("nvchad.tabufline").prev()
end, { desc = "Goto prev buffer" })
map("n", "<leader>oq", function()
  require("nvchad.tabufline").closeOtherBufs()
end, { desc = "Close other buffers" })

-- LSP mappings
map("n", "<leader>lr", "<cmd> LspRestart <CR>", { desc = "Restart LSP" })

-- DAP mappings
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Run or continue the debugger" })

-- Copilot mappings
map("n", "<leader>lct", function()
  if copilot_on then
    copilot_on = false
    require("copilot.command").disable()
    print "Copilot disabled"
  else
    copilot_on = true
    require("copilot.command").enable()
    print "Copilot enabled"
  end
end, { desc = "Copilot toggle" })
map("n", "<leader>lp", "<cmd> Copilot panel <CR>", { desc = "Copilot panel" })

-- Telescope mappings
map("n", "<leader>fs", "<cmd> Telescope lsp_document_symbols <CR>", { desc = "Find document symbols" })
map("n", "<leader>fe", "<cmd> lua MiniFiles.open() <CR>", { desc = "Open file explorer" })

-- UFO mappings
map("n", "zR", function()
  require("ufo").openAllFolds()
end, { desc = "Open all folds" })
map("n", "zM", function()
  require("ufo").closeAllFolds()
end, { desc = "Close all folds" })

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", ";", ":", { desc = "enter command mode", nowait = true })
map("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds", nowait = true })
map("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds", nowait = true })
map("v", "p", "P", { desc = "paste" })

map("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
map("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })

map("n", "ygf", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, {
  desc = "Copy absolute file path",
})

map("n", "ygr", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
end, {
  desc = "Copy relative file path",
})

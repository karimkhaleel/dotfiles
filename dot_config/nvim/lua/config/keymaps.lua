-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", ";", ":", { desc = "enter command mode", nowait = true })
map("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds", nowait = true })
map("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds", nowait = true })
map("v", "p", "P", { desc = "paste" })

-- OpenCode bindings
map({ "n", "x" }, "<leader>aa", function()
  require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode…" })
map({ "n", "x" }, "<leader>ax", function()
  require("opencode").select()
end, { desc = "Execute opencode action…" })
map({ "n", "t" }, "<leader>at", function()
  require("opencode").toggle()
end, { desc = "Toggle opencode" })

map({ "n", "x" }, "<leader>ago", function()
  return require("opencode").operator("@this ")
end, { desc = "Add range to opencode", expr = true })
map("n", "<leader>ago", function()
  return require("opencode").operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })

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

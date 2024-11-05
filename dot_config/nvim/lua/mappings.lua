require "nvchad.mappings"

local map = vim.keymap.set

-- General
map("n", ";", ":", { desc = "enter command mode", nowait = true })

map("n", "<leader>tf", function()
  require("flags").toggle_format_on_save()
end, { desc = "toggle format on save", nowait = true })

map("n", "<leader>ti", function()
  require("flags").toggle_inlay_hints()
end, { desc = "toggle inlay hints", nowait = true })

map("n", "n", "nzzzv", { desc = "next search result centered" })
map("n", "N", "Nzzzv", { desc = "previous search result centered" })
map("n", "g,", "g,zvzz", { desc = "next change centered" })
map("n", "g;", "g;zvzz", { desc = "previous change centered" })
map("n", "<C-d>", "<C-d>zz", { desc = "page down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "page up centered" })
map("n", "<C-o>", "<C-o>zz", { desc = "jump back centered" })
map("n", "<C-i>", "<C-i>zz", { desc = "jump forwards centered" })
map("n", "zt", "zt5<C-y>", { desc = "top this line" })
map("n", "zb", "zb5<C-e>", { desc = "bottom this line" })
map("v", ">", ">gv", { desc = "indent" })
map("v", "<", "<gv", { desc = "dedent" })
map("n", "k", "gk", { desc = "up" })
map("n", "j", "gj", { desc = "down" })
map("v", "p", "P", { desc = "paste" })
map("n", "<leader>ttn", "<cmd> tabnew <CR>", { desc = "create new tab" })
map("n", "<leader>ttq", "<cmd> tabclose <CR>", { desc = "close tab" })
map("n", "<leader>ttk", "<cmd> tabNext <CR>", { desc = "next tab" })
map("n", "<leader>ttj", "<cmd> tabprevious <CR>", { desc = "previous tab" })
map("n", "<leader>sf", ":echo expand('%:p')<CR>", { desc = "display full path" })

-- Disabled mappings
map("n", "<tab>", "<C-i>", { desc = "Disabled mapping" }) -- tab to jump forward
map("n", "<S-tab>", "", { desc = "Disabled mapping" })

-- Tabufline mappings
map("n", "<leader>k", function()
  require("nvchad.tabufline").next()
end, { desc = "Goto next buffer" })

map("n", "<leader>j", function()
  require("nvchad.tabufline").prev()
end, { desc = "Goto prev buffer" })

map("n", "<leader>oq", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "Close other buffers" })

-- LSP mappings
map("n", "<leader>lr", "<cmd> LspRestart <CR>", { desc = "Restart LSP" })
map("n", "<leader>lf", vim.diagnostic.open_float, { desc = "Open float" })

-- DAP mappings
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Run or continue the debugger" })
map("n", "<leader>ds", "<cmd> DapTerminate <CR>", { desc = "Stop debugger" })
map("n", "<leader>dc", "<cmd> DapStepOver <CR>", { desc = "Step over" })
map("n", "<leader>di", "<cmd> DapStepInto <CR>", { desc = "Step into" })
map("n", "<leader>do", "<cmd> DapStepOut Into CR>", { desc = "Step out" })
map("n", "<leader>dj", "<cmd> DapLoadLaunchJSON CR>", { desc = "DAP Launch JSON" })

-- Telescope mappings
map("n", "<leader>fs", "<cmd> Telescope lsp_document_symbols <CR>", { desc = "Find document symbols" })
map("n", "<leader>fi", "<cmd> Telescope import <CR>", { desc = "Search for product imports" })
map("n", "<leader>fgb", "<cmd> Telescope git_branches <CR>", { desc = "Find and checkout git branch" })
map("n", "<leader>fc", "<cmd> Telescope neoclip <CR>", { desc = "Search through yank history" })
map("n", "<leader>fm", "<cmd> Telescope macroscope <CR>", { desc = "Search through macro history" })
map("n", "<leader>fd", "<cmd> Telescope diagnostics <CR>", { desc = "Search through project diagnostics" })

-- Files
map("n", "<leader>fe", "<cmd> lua MiniFiles.open() <CR>", { desc = "Open file explorer" })

-- Diffview mappings
map("n", "<leader>gdf", "<cmd>DiffviewFileHistory %<CR>", { noremap = true, silent = true })
map("n", "<leader>gdo", "<cmd> DiffviewOpen <CR>", { desc = "Open diff view" })
map("n", "<leader>gdq", "<cmd> DiffviewClose <CR>", { desc = "Close diff view" })

-- Tree Surfer
local tree_surfer_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<CS-Up>", function()
  vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
  return "g@l"
end, { desc = "Swap TS Parent Node Up", silent = true, expr = true })
vim.keymap.set("n", "<CS-Down>", function()
  vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
  return "g@l"
end, { desc = "Swap TS Node Down", silent = true, expr = true })
map("n", "<CS-Right>", function()
  vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
  return "g@l"
end, { desc = "Swap TS Sibling Node Up", silent = true, expr = true })
map("n", "<CS-Left>", function()
  vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
  return "g@l"
end, { desc = "Swap TS Sibling Node Down", silent = true, expr = true })
map("x", "<cmd>STSSelectNextSiblingNode<cr>", "J", tree_surfer_opts)
map("x", "K", "<cmd>STSSelectPrevSiblingNode<cr>", tree_surfer_opts)
map("x", "V", "<cmd>STSSelectParentNode<cr>", tree_surfer_opts)
map("x", "C", "<cmd>STSSelectChildNode<cr>", tree_surfer_opts)

map("x", "<A-j>", "<cmd>STSSwapNextVisual<cr>", tree_surfer_opts)
map("x", "<A-k>", "<cmd>STSSwapPrevVisual<cr>", tree_surfer_opts)

-- Portal
map("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
map("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")

-- Spider
map({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
map({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
map({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })

-- Gitsigns
local gs = require "gitsigns"
map("n", "<leader>gsb", gs.stage_buffer, { desc = "Stage buffer" })
map("n", "<leader>gsh", gs.stage_hunk, { desc = "Stage hunk" })
map("n", "<leader>guh", gs.undo_stage_hunk, { desc = "Unstage hunk" })
map("n", "<leader>grh", gs.reset_hunk, { desc = "Reset hunk" })
map("n", "<leader>grb", gs.reset_buffer, { desc = "Reset buffer" })
map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
map("n", "<leader>gb", gs.blame_line, { desc = "Blame line" })
map("n", "[h", gs.prev_hunk, { desc = "Prev hunk" })
map("n", "]h", gs.next_hunk, { desc = "Next hunk" })

-- Spectre
local spectre = require "spectre"
map("n", "<leader>fr", spectre.open, { desc = "Start spectre" })

local map = vim.api.nvim_set_keymap
   
map("i", "jk", "<Esc>", {})
map("i", "kj", "<Esc>", {})
map("n", "<leader>n", [[:NvimTreeToggle<CR>]], {})
map("n", "<leader>l", [[:IndentLinesToggle<CR>]], {})
map("n", "<leader>t", [[:TagbarToggle<CR>]], {})
map("n", "<leader>ff", [[:Telescope find_files<CR>]], {})
map("n", "<leader>ut", [[:UndotreeToggle<CR>]], {})
map("n", "<leader>tr", [[:TroubleToggle<CR>]], {})

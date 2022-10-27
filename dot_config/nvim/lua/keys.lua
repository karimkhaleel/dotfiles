local map = vim.api.nvim_set_keymap

-- [[ Control ]]
map("i", "jk", "<Esc>", {})
map("i", "kj", "<Esc>", {})

map("n", "<leader>l", [[:IndentLinesToggle<CR>]], {})

-- [[ Panels ]]
map("n", "<leader>n", [[:NvimTreeToggle<CR>]], {})
map("n", "<leader>t", [[:TagbarToggle<CR>]], {})
map("n", "<leader>ff", [[:Telescope find_files<CR>]], {})
map("n", "<leader>ut", [[:UndotreeToggle<CR>]], {})
map("n", "<leader>tr", [[:TroubleToggle<CR>]], {})

-- [[ Navigation ]]
-- [[ Hop ]]

local cmd = vim.api.nvim_command
cmd("command HopWordACLine lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true})")
cmd("command HopWordBCLine lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true})")
cmd("command HopWordPreACLine lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1})")
cmd("command HopWordPreBCLine lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1})")
map("n", "<leader>hw", [[:HopWord<CR>]], {})
map("n", "<leader>hc1", [[:HopChar1<CR>]], {})
map("n", "<leader>hc2", [[:HopChar2<CR>]], {})
map("n", "<leader>hl", [[:HopLine<CR>]], {})
map("n", "<leader>hls", [[:HopLineStart<CR>]], {})
map("n", "<leader>hp", [[:HopPattern<CR>]], {})
map("n", "f", [[:HopWordACLine<CR>]], {})
map("n", "F", [[:HopWordBCLine<CR>]], {})
map("n", "t", [[:HopWordPreACLine<CR>]], {})
map("n", "T", [[:HopWordPreBCLine<CR>]], {})
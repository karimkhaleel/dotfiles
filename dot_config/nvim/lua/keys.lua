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

-- [[ Telescope ]]
map("n", "<leader>fif", [[:Telescope find_files<CR>]], {})
map("n", "<leader>fi", [[:Telescope live_grep<CR>]], {})
map("n", "<leader>fgb", [[:Telescope git_branches<CR>]], {})
map("n", "<leader>fbn", [[:Telescope builtin<CR>]], {})
map("n", "<leader>fch", [[:Telescope commands<CR>]], {})
map("n", "<leader>fman", [[:Telescope manpages<CR>]], {})
map("n", "<leader>flr", [[:Telescope lsp_references<CR>]], {})
map("n", "<leader>fld", [[:Telescope lsp_definitions<CR>]], {})

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


-- [[ LSP ]]
map("n", "K", [[:lua vim.lsp.buf.hover()<CR>]], {})
map("n", "<F2>", [[:lua vim.lsp.buf.rename()<CR>]], {})
map("n", "<leader>for", [[:lua vim.lsp.buf.format{ async = true }<CR>]], {})

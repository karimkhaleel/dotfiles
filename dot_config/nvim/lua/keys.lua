local map = vim.api.nvim_set_keymap

-- [[ Control ]]
map("i", "jk", "<Esc>", {})
map("i", "kj", "<Esc>", {})

map("n", "<leader>l", [[:IndentLinesToggle<CR>]], {})

-- [[ Panels ]]
map("n", "<leader>n", [[:NvimTreeToggle<CR>]], {})
map("n", "<leader>tag", [[:TagbarToggle<CR>]], {})
map("n", "<leader>ut", [[:UndotreeToggle<CR>]], {})
map("n", "<leader>tr", [[:TroubleToggle<CR>]], {})

-- [[ Telescope ]]
map("n", "<leader>ff", [[:Telescope live_grep<CR>]], {})
map("n", "<leader>fif", [[:Telescope find_files<CR>]], {})
map("n", "<leader>fgb", [[:Telescope git_branches<CR>]], {})
map("n", "<leader>fbn", [[:Telescope builtin<CR>]], {})
map("n", "<leader>fch", [[:Telescope commands<CR>]], {})
map("n", "<leader>fman", [[:Telescope man_pages<CR>]], {})
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
map("n", "<leader>h1", [[:HopChar1<CR>]], {})
map("n", "<leader>h2", [[:HopChar2<CR>]], {})
map("n", "<leader>hl", [[:HopLine<CR>]], {})
map("n", "<leader>hli", [[:HopLineStart<CR>]], {})
map("n", "<leader>hp", [[:HopPattern<CR>]], {})
map("n", "f", [[:HopWordACLine<CR>]], {})
map("n", "F", [[:HopWordBCLine<CR>]], {})
map("n", "t", [[:HopWordPreACLine<CR>]], {})
map("n", "T", [[:HopWordPreBCLine<CR>]], {})

-- [[ Buffers ]]
map("n", "<leader>tb", [[:BufferLinePick<CR>]], {})
map("n", "<leader>tn", [[:BufferLineCycleNext<CR>]], {})
map("n", "<leader>tp", [[:BufferLineCyclePrev<CR>]], {})
map("n", "<leader>tk", [[:BufferLinePickClose<CR>]], {})


-- [[ LSP ]]
map("n", "<F2>", [[:lua vim.lsp.buf.rename()<CR>]], {})
map("n", "<F12>", [[:lua vim.lsp.buf.rename()<CR>]], {})
map("n", "<leader>for", [[:lua vim.lsp.buf.format{ async = true }<CR>]], {})
map("n", "<leader>dia", [[:lua vim.diagnostic.open_float()<CR>]], {})

local init_keybinds = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	local keybinds = {
		['K'] = 'vim.lsp.buf.hover()',
		['<F2>'] = 'vim.lsp.buf.rename()',
		['<F12>'] = 'vim.lsp.buf.definition()',
		['<leader><F12>'] = 'vim.lsp.buf.references()',
		['<leader>for'] = 'vim.lsp.buf.format{ async = true }',
		['<leader>e'] = 'vim.diagnostic.open_float()',
		['[d'] = 'vim.diagnostic.goto_prev()',
		[']d'] = 'vim.diagnostic.goto_next()'
	}

	for seq, action in pairs(keybinds) do
		buf_set_keymap('n', seq, string.format('<Cmd>lua %s<CR>', action), {noremap=true, silent=true})
	end

	-- Set up omnifunc for manual auto complete with <C-x><C-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local servers = {
	pylsp = {
        cmd = {"pylsp"},
        on_attach = init_keybinds,
        settings = {
            pylsp = {
                configurationSources = {"flake8"},
                plugins = {
                    flake8 = { enabled = true, maxLineLength = 88 },
                    pylint = { enabled = false },
                    pycodestyle = { enabled = false },
                    pyflakes = { enabled = false },
					black = { enabled = true },
                }
            }
        }
    }
}

return servers

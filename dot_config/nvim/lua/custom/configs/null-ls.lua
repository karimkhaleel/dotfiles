local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local h = require("null-ls.helpers")
local u = require("null-ls.utils")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

local templ_fmt = h.make_builtin({
	name = "templ_fmt",
	meta = {
		url = "templ.guide",
		description = "Format templ",
	},
	method = FORMATTING,
	filetypes = { "templ" },
	generator_opts = {
		command = "/home/karim/.local/share/nvim/mason/bin/templ",
		args = {
			"fmt",
			"$FILENAME",
		},
		to_temp_file = true,
	},
	factory = h.formatter_factory,
})

local opts = {
	sources = {
		-- lua
		null_ls.builtins.formatting.stylua,

		-- js stuff
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.formatting.prettier.with({
			extra_filetypes = { "astro", "svelte" },
		}),

		-- python sfuff
		null_ls.builtins.diagnostics.ruff,
		null_ls.builtins.formatting.ruff_format,
		null_ls.builtins.formatting.isort.with({
			extra_args = { "--profile", "black" },
		}),

		null_ls.builtins.diagnostics.mypy,

		-- C/C++ stuff
		null_ls.builtins.formatting.clang_format,

		-- go stuff
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.diagnostics.golangci_lint,
		templ_fmt,

		-- nim stuff
		null_ls.builtins.formatting.nimpretty,

		-- rust stuff
		null_ls.builtins.formatting.rustfmt,

		-- sql stuff
		null_ls.builtins.diagnostics.sqlfluff,
		null_ls.builtins.formatting.sqlfluff,

		-- zig stuff
		null_ls.builtins.formatting.zigfmt,
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					if require("custom.flags").format_on_save then
						vim.lsp.buf.format({ bufnr = bufnr })
					end
				end,
			})
		end
	end,
}

return opts

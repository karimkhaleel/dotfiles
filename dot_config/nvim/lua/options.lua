require "nvchad.options"

local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

require "custom_commands"

local opt = vim.opt

opt.relativenumber = true

-- fold settings
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

opt.fillchars:append { diff = "╱" }

-- additional filetypes
vim.filetype.add {
  filename = {
    [".git/config"] = "gitconfig",
  },
  extension = {
    templ = "templ",
  },
  pattern = {
    [".*.yaml"] = function(path, bufnr, ext)
      if require("utils").is_ansible() then
        return "yaml.ansible"
      end

      return "yaml"
    end,
  },
}

vim.g.vscode_snippets_path = vim.fn.stdpath "config" .. "/lua/snippets"

-- v0.11 compatibility
vim.tbl_add_reverse_lookup = function(tbl)
  for k, v in pairs(tbl) do
    tbl[v] = k
  end
end

-- Debugging
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

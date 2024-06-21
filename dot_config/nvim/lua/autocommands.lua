local function augroup(name)
  return vim.api.nvim_create_augroup("nv_custom_group" .. name, { clear = true })
end

-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = augroup "highlight_yank",
  pattern = "*",
})

-- Go to last loction when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup "last_loc",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_set_hl(0, "TerminalCursorShape", { underline = true })
vim.api.nvim_create_autocmd("TermEnter", {
  callback = function()
    vim.cmd [[setlocal winhighlight=TermCursor:TerminalCursorShape]]
  end,
})

-- Detect djangohtml filetype
local function set_django_html_filetype()
  local path = vim.fn.expand "%:p"
  if string.match(path, ".*/templates/.*%.html$") then
    vim.bo.filetype = "htmldjango"
  end
end

vim.api.nvim_create_augroup("DjangoHtmlFiletype", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "DjangoHtmlFiletype",
  pattern = "*.html",
  callback = set_django_html_filetype,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Set textwidth to 88 for python files",
  pattern = "*.py",
  callback = function()
    vim.bo.textwidth = 120
  end,
})

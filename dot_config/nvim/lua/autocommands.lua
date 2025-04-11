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

-- Detect django html type files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup "djangohtml",
  pattern = "*.html",
  callback = function()
    local path = vim.fn.expand "%:p"

    local function is_django_project()
      local dir = vim.fn.fnamemodify(path, ":p:h")

      while dir ~= "/" do
        if vim.fn.glob(dir .. "/manage.py") ~= "" then
          return true
        end
        dir = vim.fn.fnamemodify(dir, ":h")
      end
      return false
    end

    if string.match(path, ".*/templates/.*%.html$") and is_django_project() then
      vim.bo.filetype = "htmldjango"
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Set textwidth to 120 for python files",
  pattern = "*.py",
  callback = function()
    vim.bo.textwidth = 120
  end,
})

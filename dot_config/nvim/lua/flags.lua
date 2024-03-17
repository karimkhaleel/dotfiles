local M = {}

M.format_on_save = true
M.inlay_hints = false

M.toggle_format_on_save = function()
  M.format_on_save = not M.format_on_save
  if M.format_on_save then
    print "Format on save enabled"
  else
    print "Format on save disabled"
  end
end

M.toggle_inlay_hints = function()
  M.inlay_hints = not M.inlay_hints
  vim.lsp.inlay_hint.enable(0, M.inlay_hints)
  if M.inlay_hints then
    print "Inlay hints enabled"
  else
    print "Inlay hints disabled"
  end
end

return M

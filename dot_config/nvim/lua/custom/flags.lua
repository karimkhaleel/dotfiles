local M = {}

M.format_on_save = true

M.toggle_format_on_save = function()
  M.format_on_save = not M.format_on_save
  if M.format_on_save then
    print "Format on save enabled"
  else
    print "Format on save disabled"
  end
end

return M

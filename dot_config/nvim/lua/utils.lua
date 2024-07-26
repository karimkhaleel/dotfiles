local M = {}

---Gets current buffer as a list of strings
---@return string[]
M.get_buffer_content = function()
  local buf = vim.api.nvim_get_current_buf()
  return vim.api.nvim_buf_get_lines(buf, 0, -1, false)
end

--- File type stuff

---Checks whether a `yaml` file looks like an `ansible` file by looking
---for `name` and `tasks` keys
---@return boolean
M.is_ansible = function()
  local content = M.get_buffer_content()
  local name_exists = false
  local tasks_exists = false
  for _, line in ipairs(content) do
    if not name_exists and line:match "^%- name: [%w%s]+$" then
      name_exists = true
    end
    if not tasks_exists and line:match "^ *tasks:$" then
      tasks_exists = true
    end

    if name_exists and tasks_exists then
      return true
    end
  end
  return false
end

return M

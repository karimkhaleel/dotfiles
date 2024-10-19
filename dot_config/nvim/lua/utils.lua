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

---Parses an arg string into a table
---@param str string
---@return table
M.parse_arg_string = function(str)
  local result = {}
  if str == nil then
    return result
  end
  for pair in str:gmatch "%S+" do
    local key, value = pair:match "([^=]+)=(.+)"
    if key and value then
      result[key] = value
    end
  end
  return result
end

---@param cmd string
---@return string
M.capture_command_output = function(cmd)
  local is_windows = package.config:sub(1, 1) == "\\"
  local null_device = is_windows and "NUL" or "/dev/null"

  -- Redirect stderr to null device
  local full_cmd = is_windows and ('cmd /c "' .. cmd .. " 2>" .. null_device .. '"') or (cmd .. " 2>" .. null_device)

  local handle, err = io.popen(full_cmd)
  if not handle then
    return ""
  end

  local result = handle:read "*a"
  local success, _, exit_code = handle:close()

  if not success or exit_code ~= 0 then
    return ""
  end

  return (result:gsub("^%s*(.-)%s*$", "%1")) -- Trim whitespace
end

return M

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

  local handle = io.popen(full_cmd)
  if not handle then
    return ""
  end

  local result = handle:read "*a"
  handle:close()

  return (result:gsub("^%s*(.-)%s*$", "%1")) -- Trim leading/trailing whitespace
end

local registry = require "mason-registry"

M.get_executable_path = function(package_name, executable_name)
  local ok, pkg = pcall(registry.get_package, package_name)
  if not ok then
    return
  end

  if not pkg:is_installed() then
    return
  end

  return vim.fn.exepath(executable_name)
end

function M.first_nonempty(...)
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    if v and v ~= "" then
      return v
    end
  end
end

return M

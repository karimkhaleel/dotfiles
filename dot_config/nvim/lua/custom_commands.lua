vim.api.nvim_create_user_command("Redir", function(ctx)
  local cmd = vim.api.nvim_parse_cmd(ctx.args, {})
  local lines = vim.split(vim.api.nvim_cmd(cmd, { output = true }), "\n", { plain = true })
  vim.cmd "vnew"
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.opt_local.modified = false
end, { nargs = "+", complete = "command" })

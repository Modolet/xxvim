local M = {}

function M.other_buffer()
  vim.cmd("buffer #")
end

function M.delete_buffer_and_window()
  vim.cmd("bdelete")
  pcall(vim.cmd, "close")
end

function M.close_other_buffers()
  local current = vim.api.nvim_get_current_buf()
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if buffer ~= current and vim.bo[buffer].buflisted then
      pcall(vim.api.nvim_buf_delete, buffer, { force = false })
    end
  end
end

function M.toggle_zoom()
  if vim.t.xxvim_zoom_win and vim.api.nvim_win_is_valid(vim.t.xxvim_zoom_win) then
    vim.cmd("tabclose")
    vim.t.xxvim_zoom_win = nil
    return
  end
  vim.cmd("tab split")
  vim.t.xxvim_zoom_win = vim.api.nvim_get_current_win()
end

function M.setup_commands()
  vim.api.nvim_create_user_command("XxvimOtherBuffer", M.other_buffer, {})
  vim.api.nvim_create_user_command("XxvimDeleteBufferAndWindow", M.delete_buffer_and_window, {})
  vim.api.nvim_create_user_command("XxvimToggleZoom", M.toggle_zoom, {})
end

return M

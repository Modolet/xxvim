local M = {}

local function cmd_with_confirm(command)
  vim.cmd("confirm " .. command)
end

local function delete_buffer(buffer)
  cmd_with_confirm(("bdelete %d"):format(buffer))
end

function M.other_buffer()
  vim.cmd("buffer #")
end

function M.delete_buffer_and_window()
  cmd_with_confirm("bdelete")
  pcall(vim.cmd, "close")
end

function M.close_other_buffers()
  local current = vim.api.nvim_get_current_buf()
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if buffer ~= current and vim.bo[buffer].buflisted then
      delete_buffer(buffer)
    end
  end
end

function M.quit_current()
  cmd_with_confirm("q")
end

function M.quit_all()
  cmd_with_confirm("qa")
end

function M.setup_quit_abbreviations()
  local abbreviations = {
    q = "confirm q",
    qa = "confirm qa",
    quit = "confirm quit",
    qall = "confirm qall",
  }

  for from, to in pairs(abbreviations) do
    vim.cmd((
      "cnoreabbrev <expr> %s ((getcmdtype() == ':' && getcmdline() == '%s') ? '%s' : '%s')"
    ):format(from, from, to, from))
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
  vim.api.nvim_create_user_command("XxvimCloseOtherBuffers", M.close_other_buffers, {})
  vim.api.nvim_create_user_command("XxvimQuit", M.quit_current, {})
  vim.api.nvim_create_user_command("XxvimQuitAll", M.quit_all, {})
  vim.api.nvim_create_user_command("XxvimToggleZoom", M.toggle_zoom, {})
  M.setup_quit_abbreviations()
end

return M

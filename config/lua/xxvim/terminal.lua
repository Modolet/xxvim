local M = {}

local state = {
  float_term = nil,
  bottom_term = nil,
}

local function create_terminal_buffer(command)
  local buffer = vim.api.nvim_create_buf(false, true)
  vim.bo[buffer].bufhidden = "hide"
  vim.bo[buffer].filetype = "terminal"
  return buffer, command or vim.o.shell
end

local function start_terminal(buffer, command)
  vim.api.nvim_buf_call(buffer, function()
    vim.fn.termopen(command)
    vim.cmd("startinsert")
  end)
end

function M.toggle_float_terminal(command)
  if state.float_term and vim.api.nvim_win_is_valid(state.float_term) then
    vim.api.nvim_win_close(state.float_term, true)
    state.float_term = nil
    return
  end

  local buffer, cmd = create_terminal_buffer(command)
  local width = math.floor(vim.o.columns * 0.85)
  local height = math.floor(vim.o.lines * 0.75)
  local row = math.floor((vim.o.lines - height) / 2 - 1)
  local col = math.floor((vim.o.columns - width) / 2)

  state.float_term = vim.api.nvim_open_win(buffer, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  start_terminal(buffer, cmd)
end

function M.toggle_bottom_terminal(command)
  if state.bottom_term and vim.api.nvim_win_is_valid(state.bottom_term) then
    vim.api.nvim_win_close(state.bottom_term, true)
    state.bottom_term = nil
    return
  end

  vim.cmd("botright 15split")
  state.bottom_term = vim.api.nvim_get_current_win()
  local buffer, cmd = create_terminal_buffer(command)
  vim.api.nvim_win_set_buf(state.bottom_term, buffer)
  start_terminal(buffer, cmd)
end

function M.toggle_lazygit()
  M.toggle_float_terminal("lazygit")
end

function M.setup_commands()
  vim.api.nvim_create_user_command("XxvimFloatTerm", function(opts)
    M.toggle_float_terminal(opts.args ~= "" and opts.args or nil)
  end, { nargs = "*" })
  vim.api.nvim_create_user_command("XxvimBottomTerm", function(opts)
    M.toggle_bottom_terminal(opts.args ~= "" and opts.args or nil)
  end, { nargs = "*" })
  vim.api.nvim_create_user_command("XxvimLazyGit", M.toggle_lazygit, {})
end

return M

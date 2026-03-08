local M = {}

local terminals = {
  float = {
    layout = "float",
    command = nil,
    win = nil,
    buf = nil,
    job = nil,
  },
  bottom = {
    layout = "bottom",
    command = nil,
    win = nil,
    buf = nil,
    job = nil,
  },
  lazygit = {
    layout = "float",
    command = "lazygit",
    win = nil,
    buf = nil,
    job = nil,
    auto_close_on_exit = true,
  },
}

local function is_valid_buf(buffer)
  return buffer and vim.api.nvim_buf_is_valid(buffer)
end

local function is_valid_win(window)
  return window and vim.api.nvim_win_is_valid(window)
end

local open_window
local setup_terminal_keymaps

local function reset_terminal(name)
  local terminal = terminals[name]
  terminal.win = nil
  terminal.buf = nil
  terminal.job = nil
end

local function close_terminal(name)
  local terminal = terminals[name]
  if terminal.job and vim.fn.jobwait({ terminal.job }, 0)[1] == -1 then
    pcall(vim.fn.jobstop, terminal.job)
  end
  if is_valid_win(terminal.win) then
    pcall(vim.api.nvim_win_close, terminal.win, true)
  end
  if is_valid_buf(terminal.buf) then
    pcall(vim.api.nvim_buf_delete, terminal.buf, { force = true })
  end
  reset_terminal(name)
end

local function close_terminal_window(name)
  local terminal = terminals[name]
  if is_valid_win(terminal.win) then
    pcall(vim.api.nvim_win_close, terminal.win, true)
  end
  terminal.win = nil
end

local function reopen_terminal(name)
  local terminal = terminals[name]
  if not is_valid_buf(terminal.buf) then
    reset_terminal(name)
    return false
  end

  terminal.win = open_window(terminal.buf, terminal.layout)
  setup_terminal_keymaps(terminal.buf, name)
  vim.api.nvim_set_current_win(terminal.win)
  vim.cmd("startinsert")
  return true
end

setup_terminal_keymaps = function(buffer, name)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      buffer = buffer,
      silent = true,
      nowait = true,
      desc = desc,
    })
  end

  map("t", "<Esc><Esc>", [[<C-\\><C-n>]], "Terminal Normal Mode")
  map("n", "q", function()
    close_terminal(name)
  end, "Close Terminal")
  map("t", "<C-q>", function()
    close_terminal(name)
  end, "Close Terminal")
end

open_window = function(buffer, layout)
  if layout == "bottom" then
    vim.cmd("botright 15split")
    local window = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(window, buffer)
    return window
  end

  local width = math.floor(vim.o.columns * 0.85)
  local height = math.floor(vim.o.lines * 0.75)
  local row = math.floor((vim.o.lines - height) / 2 - 1)
  local col = math.floor((vim.o.columns - width) / 2)

  return vim.api.nvim_open_win(buffer, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })
end

local function spawn_terminal(name, command)
  local terminal = terminals[name]
  local buffer = vim.api.nvim_create_buf(false, true)
  local cmd = command or terminal.command or vim.o.shell

  terminal.buf = buffer
  terminal.command = cmd

  vim.bo[buffer].bufhidden = "hide"
  vim.bo[buffer].filetype = "terminal"

  terminal.win = open_window(buffer, terminal.layout)
  setup_terminal_keymaps(buffer, name)

  vim.api.nvim_buf_call(buffer, function()
    terminal.job = vim.fn.termopen(cmd, {
      on_exit = function()
        vim.schedule(function()
          if terminal.auto_close_on_exit then
            close_terminal_window(name)
          elseif is_valid_buf(terminal.buf) then
            terminal.job = nil
          else
            reset_terminal(name)
          end
        end)
      end,
    })
    vim.cmd("startinsert")
  end)
end

local function toggle_terminal(name, command)
  local terminal = terminals[name]
  if is_valid_win(terminal.win) then
    close_terminal_window(name)
    return
  end

  if is_valid_buf(terminal.buf) and reopen_terminal(name) then
    return
  end

  spawn_terminal(name, command)
end

function M.toggle_float_terminal(command)
  toggle_terminal("float", command)
end

function M.toggle_bottom_terminal(command)
  toggle_terminal("bottom", command)
end

function M.toggle_lazygit()
  toggle_terminal("lazygit")
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

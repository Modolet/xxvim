local M = {}

local tmux_directions = {
  h = "-L",
  j = "-D",
  k = "-U",
  l = "-R",
}

local kitty_directions = {
  h = "left",
  j = "bottom",
  k = "top",
  l = "right",
}

local function can_use_tmux()
  return vim.env.TMUX ~= nil and vim.env.TMUX ~= "" and vim.fn.executable("tmux") == 1
end

local function can_use_kitty()
  return vim.env.KITTY_WINDOW_ID ~= nil and vim.env.KITTY_WINDOW_ID ~= "" and vim.fn.executable("kitty") == 1
end

local function navigate_tmux(direction)
  local tmux_flag = tmux_directions[direction]
  if tmux_flag == nil or not can_use_tmux() then
    return false
  end

  vim.fn.system({ "tmux", "select-pane", tmux_flag })
  return vim.v.shell_error == 0
end

local function navigate_kitty(direction)
  local kitty_direction = kitty_directions[direction]
  if kitty_direction == nil or not can_use_kitty() then
    return false
  end

  vim.fn.system({ "kitty", "@", "action", "neighboring_window", kitty_direction })
  return vim.v.shell_error == 0
end

function M.navigate(direction)
  local current_window = vim.api.nvim_get_current_win()
  vim.cmd("silent! wincmd " .. direction)

  if vim.api.nvim_get_current_win() ~= current_window then
    return true
  end

  if navigate_tmux(direction) then
    return true
  end

  return navigate_kitty(direction)
end

function M.navigate_from_terminal(direction)
  local normal_mode = vim.api.nvim_replace_termcodes("<C-\\\\><C-n>", true, false, true)
  vim.api.nvim_feedkeys(normal_mode, "n", false)
  vim.schedule(function()
    M.navigate(direction)
  end)
end

return M

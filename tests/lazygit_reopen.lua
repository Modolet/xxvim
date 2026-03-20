local term = require('xxvim.terminal')
local _, toggle_terminal = debug.getupvalue(term.toggle_lazygit, 1)
local _, terminals = debug.getupvalue(toggle_terminal, 1)
local lazygit = terminals.lazygit

local function assert_wait(timeout, predicate, message)
  local ok = vim.wait(timeout, predicate, 20)
  assert(ok, message)
end

lazygit.command = "sh -c 'exit 0'"
term.toggle_lazygit()
assert_wait(1000, function()
  return lazygit.buf ~= nil
end, '第一次打开未创建终端 buffer')

local first_buf = lazygit.buf

assert_wait(1000, function()
  return lazygit.win == nil
end, '第一次退出后未自动关闭窗口')

lazygit.command = "sh -c 'sleep 5'"
term.toggle_lazygit()
assert_wait(1000, function()
  return lazygit.win ~= nil
end, '第二次打开未创建窗口')

assert(lazygit.buf ~= first_buf, 'lazygit 退出后再次打开时复用了已退出的终端 buffer')

if lazygit.job then
  pcall(vim.fn.jobstop, lazygit.job)
end
vim.cmd('qa!')

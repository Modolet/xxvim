local autoread = require("xxvim.autoread")

local function assert_equal(actual, expected, message)
  assert(actual == expected, string.format("%s\nexpected: %s\nactual: %s", message, expected, actual))
end

autoread.setup()

assert_equal(vim.o.autoread, true, "setup 应启用 autoread")

local autocmds = vim.api.nvim_get_autocmds({ group = "xxvim_autoread" })
local seen_events = {}
for _, autocmd in ipairs(autocmds) do
  seen_events[autocmd.event] = true
end

for _, event in ipairs({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermLeave" }) do
  assert(seen_events[event], "缺少自动 checktime 事件: " .. event)
end

local path = vim.fn.tempname()
vim.fn.writefile({ "old" }, path)
vim.cmd("edit " .. vim.fn.fnameescape(path))
assert_equal(vim.api.nvim_buf_get_lines(0, 0, 1, false)[1], "old", "初始文件内容不符合预期")

vim.fn.writefile({ "new" }, path)
local now = os.time() + 2
assert(vim.uv.fs_utime(path, now, now), "无法更新时间戳")

autoread.checktime()

assert_equal(vim.api.nvim_buf_get_lines(0, 0, 1, false)[1], "new", "外部修改后应自动重新读取 buffer")

vim.cmd("qa!")

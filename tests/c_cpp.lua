local c_cpp = require("xxvim.c_cpp")

local function assert_equal(actual, expected, message)
  assert(actual == expected, string.format("%s\nexpected: %s\nactual: %s", message, expected, actual))
end

local root = vim.fn.tempname()
vim.fn.mkdir(root, "p")
vim.fn.writefile({}, root .. "/driver.c")
vim.fn.writefile({}, root .. "/driver.h")
vim.fn.writefile({}, root .. "/device.cpp")
vim.fn.writefile({}, root .. "/device.hpp")

assert_equal(
  c_cpp.find_alternate_file(root .. "/driver.c"),
  root .. "/driver.h",
  "C source 应切换到同名 header"
)

assert_equal(
  c_cpp.find_alternate_file(root .. "/driver.h"),
  root .. "/driver.c",
  "C header 应切换到同名 source"
)

assert_equal(
  c_cpp.find_alternate_file(root .. "/device.cpp"),
  root .. "/device.hpp",
  "C++ source 应切换到同名 header"
)

assert_equal(c_cpp.find_alternate_file(root .. "/missing.c"), nil, "不存在候选文件时应返回 nil")
assert_equal(c_cpp.find_alternate_file(root .. "/README.md"), nil, "非 C/C++ 文件应返回 nil")

vim.cmd("qa!")

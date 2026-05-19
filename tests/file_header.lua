local header = require("xxvim.file_header")

local function assert_equal(actual, expected, message)
  assert(actual == expected, string.format("%s\nexpected:\n%s\nactual:\n%s", message, expected, actual))
end

local lines = header.make_header({
  filename = "sis7900_dbg.h",
  author = "yuecheng.yang",
  date = "2026-04-27",
})

assert_equal(table.concat(lines, "\n"), table.concat({
  "/**",
  "@file sis7900_dbg.h",
  "@brief",
  "@author yuecheng.yang",
  "@date 2026-04-27",
  "*/",
  "",
}, "\n"), "文件头内容不符合预期")

assert(header.supports_file("main.c"), "应支持 C 文件")
assert(header.supports_file("main.cpp"), "应支持 C++ 文件")
assert(header.supports_file("lib.rs"), "应支持 Rust 文件")
assert(not header.supports_file("README.md"), "不应支持 Markdown 文件")

local temp_root = vim.fn.tempname()
vim.fn.mkdir(temp_root, "p")
vim.fn.system({ "git", "-C", temp_root, "init" })
vim.fn.system({ "git", "-C", temp_root, "config", "user.name", "repo.user" })
assert_equal(header.author_for(temp_root .. "/src/main.c"), "repo.user", "应优先读取当前仓库 user.name")

vim.cmd("enew")
vim.api.nvim_buf_set_name(0, "/tmp/sis7900_dbg.rs")
header.insert_if_needed(0, {
  author = "repo.user",
  date = "2026-04-27",
})

assert_equal(vim.api.nvim_buf_get_lines(0, 0, 7, false)[1], "/**", "空 Rust buffer 应插入文件头")
assert_equal(vim.api.nvim_buf_get_lines(0, 1, 2, false)[1], "@file sis7900_dbg.rs", "应使用当前文件名")

vim.api.nvim_buf_set_lines(0, 0, -1, false, { "fn main() {}" })
header.insert_if_needed(0, {
  author = "repo.user",
  date = "2026-04-27",
})

assert_equal(vim.api.nvim_buf_get_lines(0, 0, 1, false)[1], "fn main() {}", "非空 buffer 不应插入文件头")

local explorer_created = temp_root .. "/src/explorer_created.c"
vim.fn.mkdir(vim.fn.fnamemodify(explorer_created, ":h"), "p")
vim.fn.writefile({}, explorer_created)

header.setup()
vim.cmd("edit! " .. vim.fn.fnameescape(explorer_created))

assert_equal(vim.api.nvim_buf_get_lines(0, 0, 1, false)[1], "/**", "打开由文件树预先创建的空文件时应插入文件头")
assert_equal(vim.api.nvim_buf_get_lines(0, 1, 2, false)[1], "@file explorer_created.c", "文件树新建文件应使用当前文件名")

vim.cmd("qa!")

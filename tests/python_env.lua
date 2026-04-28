local python = require("xxvim.python")

local function assert_equal(actual, expected, message)
  assert(actual == expected, string.format("%s\nexpected: %s\nactual: %s", message, expected, actual))
end

local temp_root = vim.fn.tempname()
vim.fn.mkdir(temp_root .. "/.venv/bin", "p")
vim.fn.writefile({}, temp_root .. "/pyproject.toml")
vim.fn.writefile({}, temp_root .. "/.venv/bin/python")

local interpreter = python.interpreter_for(temp_root .. "/pkg/app.py")
assert_equal(interpreter, temp_root .. "/.venv/bin/python", "应优先使用项目 .venv 解释器")

local settings = python.basedpyright_settings_for(temp_root .. "/pkg/app.py")
assert_equal(settings.venvPath, temp_root, "basedpyright venvPath 应指向项目根")
assert_equal(settings.venv, ".venv", "basedpyright venv 应指向 uv 默认环境")

python.setup_lsp()
local lsp_config = { root_dir = temp_root }
vim.lsp.config._configs.basedpyright.before_init(nil, lsp_config)
assert_equal(lsp_config.settings.python.pythonPath, temp_root .. "/.venv/bin/python", "LSP 应使用项目 .venv 解释器")
assert_equal(lsp_config.settings.python.venvPath, temp_root, "LSP 应设置 basedpyright 的 venvPath")
assert_equal(lsp_config.settings.python.venv, ".venv", "LSP 应设置 basedpyright 的 venv")

local no_venv_root = vim.fn.tempname()
vim.fn.mkdir(no_venv_root, "p")
vim.fn.writefile({}, no_venv_root .. "/pyproject.toml")

assert_equal(python.interpreter_for(no_venv_root .. "/main.py"), "python", "没有 .venv 时应回退到 PATH 中的 python")
assert(python.basedpyright_settings_for(no_venv_root .. "/main.py") == nil, "没有 .venv 时不应覆盖 basedpyright 环境")

vim.cmd("qa!")

local M = {}

function M.project_root()
  local current = vim.api.nvim_buf_get_name(0)
  local start = current ~= "" and vim.fs.dirname(current) or vim.loop.cwd()
  local markers = {
    ".git",
    "flake.nix",
    "Cargo.toml",
    "pyproject.toml",
    "setup.py",
    "CMakeLists.txt",
    "compile_commands.json",
    "package.json",
  }
  local found = vim.fs.find(markers, { path = start, upward = true })[1]
  if found then
    return vim.fs.dirname(found)
  end
  return vim.loop.cwd()
end

function M.cd_root()
  local root = M.project_root()
  vim.cmd("cd " .. vim.fn.fnameescape(root))
  vim.notify("Changed cwd to " .. root)
end

function M.setup_commands()
  vim.api.nvim_create_user_command("XxvimCdRoot", M.cd_root, {})
end

return M

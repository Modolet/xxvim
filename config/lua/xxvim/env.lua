local M = {}

local function split_path(path)
  local entries = {}
  if not path or path == "" then
    return entries
  end

  for entry in string.gmatch(path, "([^:]+)") do
    table.insert(entries, entry)
  end

  return entries
end

local function join_path(entries)
  return table.concat(entries, ":")
end

local function shell_name(path)
  return vim.fs.basename(path or "")
end

local function in_devshell_bash()
  return vim.env.IN_NIX_SHELL ~= nil and shell_name(vim.o.shell) == "bash"
end

local function apply_shell_defaults(shell)
  if shell_name(shell) ~= "nu" then
    return
  end

  vim.o.shell = shell
  vim.o.shellcmdflag = "-c"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
  vim.o.shellredir = ">"
  vim.o.shellpipe = "| tee"
end

function M.setup_path_precedence()
  local current_path = vim.env.PATH or ""
  local fallback_path = vim.env.XXVIM_TOOL_FALLBACK_PATH or ""

  if current_path == "" or fallback_path == "" then
    return
  end

  local fallback_entries = split_path(fallback_path)
  if vim.tbl_isempty(fallback_entries) then
    return
  end

  local fallback_lookup = {}
  for _, entry in ipairs(fallback_entries) do
    fallback_lookup[entry] = true
  end

  local reordered = {}
  for _, entry in ipairs(split_path(current_path)) do
    if not fallback_lookup[entry] then
      table.insert(reordered, entry)
    end
  end

  for _, entry in ipairs(fallback_entries) do
    table.insert(reordered, entry)
  end

  vim.env.PATH = join_path(reordered)
end

function M.setup_shell_precedence()
  if not in_devshell_bash() then
    return
  end
  local passwd = vim.uv.os_get_passwd()
  if not passwd or not passwd.shell or vim.fn.executable(passwd.shell) ~= 1 then
    return
  end

  vim.env.SHELL = passwd.shell
  apply_shell_defaults(passwd.shell)
end

function M.interactive_shell()
  local preferred = in_devshell_bash() and vim.env.SHELL or vim.o.shell
  for _, shell in ipairs({ preferred or "", vim.o.shell, vim.env.SHELL or "", "sh" }) do
    if vim.fn.executable(shell) == 1 then
      return shell
    end
  end
  error("No executable interactive shell found")
end

return M

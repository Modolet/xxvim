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

local function current_shell_is_nix_bash()
  local current_shell = vim.o.shell or vim.env.SHELL or ""
  return current_shell:match("^/nix/store/.*/bin/bash$") ~= nil
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
  local passwd = vim.uv.os_get_passwd()
  if not passwd or not passwd.shell or passwd.shell == "" then
    return
  end

  if vim.env.IN_NIX_SHELL ~= nil and current_shell_is_nix_bash() then
    vim.env.SHELL = passwd.shell
    apply_shell_defaults(passwd.shell)
  end
end

return M

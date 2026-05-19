local M = {}

local supported_extensions = {
  c = true,
  h = true,
  cc = true,
  cpp = true,
  cxx = true,
  hpp = true,
  hh = true,
  hxx = true,
  rs = true,
}

local function trim(value)
  return (value or ""):gsub("^%s+", ""):gsub("%s+$", "")
end

local function systemlist(args)
  local ok, output = pcall(vim.fn.systemlist, args)
  if not ok or vim.v.shell_error ~= 0 then
    return nil
  end

  local value = trim(table.concat(output, "\n"))
  if value == "" then
    return nil
  end

  return value
end

local function git_local_user(path)
  local dir = vim.fn.fnamemodify(path, ":p:h")
  if dir == "" then
    dir = vim.loop.cwd()
  end

  while dir ~= "" and vim.fn.isdirectory(dir) == 0 do
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
      break
    end
    dir = parent
  end

  return systemlist({ "git", "-C", dir, "config", "--local", "--get", "user.name" })
end

local function git_global_user()
  return systemlist({ "git", "config", "--global", "--get", "user.name" })
end

local function system_user()
  local user = os.getenv("USER") or os.getenv("USERNAME") or os.getenv("LOGNAME")
  if user and user ~= "" then
    return user
  end

  local passwd = vim.loop.os_get_passwd()
  return passwd and passwd.username or "unknown"
end

function M.author_for(path)
  return git_local_user(path) or git_global_user() or system_user()
end

function M.supports_file(path)
  local extension = vim.fn.fnamemodify(path, ":e"):lower()
  return supported_extensions[extension] == true
end

function M.make_header(opts)
  opts = opts or {}

  return {
    "/**",
    string.format("@file %s", opts.filename or ""),
    "@brief",
    string.format("@author %s", opts.author or ""),
    string.format("@date %s", opts.date or os.date("%Y-%m-%d")),
    "*/",
    "",
  }
end

function M.insert_if_needed(bufnr, opts)
  bufnr = bufnr or 0
  opts = opts or {}

  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  if not vim.api.nvim_get_option_value("modifiable", { buf = bufnr }) then
    return
  end

  local path = opts.path or vim.api.nvim_buf_get_name(bufnr)
  if path == "" or not M.supports_file(path) then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  if #lines > 1 or (#lines == 1 and lines[1] ~= "") then
    return
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, M.make_header({
    filename = vim.fn.fnamemodify(path, ":t"),
    author = opts.author or M.author_for(path),
    date = opts.date or os.date("%Y-%m-%d"),
  }))
end

function M.setup()
  local group = vim.api.nvim_create_augroup("xxvim_file_header", { clear = true })

  vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
    group = group,
    pattern = { "*.c", "*.h", "*.cc", "*.cpp", "*.cxx", "*.hpp", "*.hh", "*.hxx", "*.rs" },
    callback = function(args)
      M.insert_if_needed(args.buf)
    end,
  })
end

return M

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

return M

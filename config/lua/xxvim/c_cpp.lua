local M = {}

local header_extensions = { "h", "hh", "hpp", "hxx" }
local source_extensions = { "c", "cc", "cpp", "cxx" }

local function contains(values, value)
  for _, item in ipairs(values) do
    if item == value then
      return true
    end
  end
  return false
end

local function alternate_extensions(extension)
  if contains(header_extensions, extension) then
    return source_extensions
  end
  if contains(source_extensions, extension) then
    return header_extensions
  end
end

function M.find_alternate_file(path)
  if path == "" then
    return nil
  end

  local extension = vim.fn.fnamemodify(path, ":e"):lower()
  local candidates = alternate_extensions(extension)
  if not candidates then
    return nil
  end

  local base = vim.fn.fnamemodify(path, ":r")
  for _, candidate in ipairs(candidates) do
    local alternate = base .. "." .. candidate
    if vim.fn.filereadable(alternate) == 1 then
      return alternate
    end
  end
end

local function clangd_clients(bufnr)
  local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
  return get_clients({ bufnr = bufnr, name = "clangd" })
end

local function edit(path)
  vim.cmd.edit(vim.fn.fnameescape(path))
end

function M.switch_source_header()
  local bufnr = vim.api.nvim_get_current_buf()
  local path = vim.api.nvim_buf_get_name(bufnr)
  local clients = clangd_clients(bufnr)

  if #clients > 0 then
    local params = { uri = vim.uri_from_bufnr(bufnr) }
    clients[1].request("textDocument/switchSourceHeader", params, function(err, result)
      if err then
        vim.notify(err.message or "clangd switch source/header failed", vim.log.levels.WARN)
        return
      end

      if result and result ~= "" then
        vim.schedule(function()
          edit(vim.uri_to_fname(result))
        end)
        return
      end

      vim.schedule(function()
        local alternate = M.find_alternate_file(path)
        if alternate then
          edit(alternate)
        else
          vim.notify("No matching source/header file found", vim.log.levels.WARN)
        end
      end)
    end, bufnr)
    return
  end

  local alternate = M.find_alternate_file(path)
  if alternate then
    edit(alternate)
  else
    vim.notify("No matching source/header file found", vim.log.levels.WARN)
  end
end

return M

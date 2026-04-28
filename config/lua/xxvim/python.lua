local M = {}

local venv_name = ".venv"

local function join(...)
  return table.concat({ ... }, "/")
end

local function is_file(path)
  local stat = vim.uv.fs_stat(path)
  return stat ~= nil and stat.type == "file"
end

function M.project_root(path)
  return require("xxvim.root").detect(path)
end

function M.venv_python_for(path)
  local root = M.project_root(path)
  local candidate = join(root, venv_name, "bin", "python")
  if is_file(candidate) then
    return candidate, root
  end
  return nil, root
end

function M.interpreter_for(path)
  local interpreter = M.venv_python_for(path)
  return interpreter or "python"
end

function M.current_interpreter()
  local current = vim.api.nvim_buf_get_name(0)
  return M.interpreter_for(current ~= "" and current or vim.uv.cwd())
end

function M.basedpyright_settings_for(path)
  local interpreter, root = M.venv_python_for(path)
  if not interpreter then
    return nil
  end

  return {
    pythonPath = interpreter,
    venvPath = root,
    venv = venv_name,
  }
end

function M.setup_lsp()
  vim.lsp.config("basedpyright", {
    before_init = function(_, config)
      local root = config.root_dir or vim.uv.cwd()
      local settings = M.basedpyright_settings_for(root)
      if not settings then
        return
      end

      config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
        python = settings,
      })
    end,
  })
end

return M

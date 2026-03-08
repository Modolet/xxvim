local M = {}

local root = require("xxvim.root")

local function persistence_dir()
  return vim.fn.stdpath("state") .. "/sessions/"
end

local function session_file_prefix(dir)
  return persistence_dir() .. vim.fs.normalize(dir):gsub("[\\\\/:]+", "%%")
end

local function has_session(dir)
  return #vim.fn.glob(session_file_prefix(dir) .. "*.vim", false, true) > 0
end

function M.save_session()
  local session = vim.fn.stdpath("state") .. "/xxvim-session.vim"
  vim.cmd("mksession! " .. vim.fn.fnameescape(session))
  vim.notify("Session saved: " .. session)
end

function M.restore_session()
  local session = vim.fn.stdpath("state") .. "/xxvim-session.vim"
  if vim.fn.filereadable(session) == 1 then
    vim.cmd("silent! source " .. vim.fn.fnameescape(session))
    vim.notify("Session restored")
  else
    vim.notify("No saved session", vim.log.levels.WARN)
  end
end

function M.load_last()
  local ok, persistence = pcall(require, "persistence")
  if ok then
    persistence.load({ last = true })
  end
end

function M.load_cwd()
  local ok, persistence = pcall(require, "persistence")
  if ok then
    persistence.load({ last = false })
  end
end

function M.restore_project(dir)
  local ok, persistence = pcall(require, "persistence")
  local project_dir = root.set_cwd(dir, { global = true, silent = true })
  if ok and has_session(project_dir) then
    persistence.load({ last = false })
    vim.notify("Session restored: " .. project_dir)
    return true
  end
  return false, project_dir
end

function M.open_project(dir)
  local restored, project_dir = M.restore_project(dir)
  if restored then
    return
  end
  Snacks.picker.files({ cwd = project_dir })
end

function M.recent_projects()
  local projects = {}
  local seen = {}
  for _, file in ipairs(vim.v.oldfiles) do
    local project_dir = root.detect(file)
    if project_dir ~= "" and not seen[project_dir] then
      seen[project_dir] = true
      table.insert(projects, project_dir)
    end
  end
  if #projects == 0 then
    vim.notify("No recent projects", vim.log.levels.INFO)
    return
  end
  Snacks.picker.select(projects, {
    prompt = "Recent Projects",
    format_item = function(item)
      local session_mark = has_session(item) and " 󱂬" or ""
      return vim.fn.fnamemodify(item, ":~") .. session_mark
    end,
  }, function(choice)
    if choice then
      M.open_project(choice)
    end
  end)
end

function M.setup_commands()
  vim.api.nvim_create_user_command("XxvimSessionSave", M.save_session, {})
  vim.api.nvim_create_user_command("XxvimSessionRestore", M.restore_session, {})
  vim.api.nvim_create_user_command("XxvimRecentProjects", M.recent_projects, {})
  vim.api.nvim_create_user_command("XxvimSessionLoadLast", M.load_last, {})
  vim.api.nvim_create_user_command("XxvimSessionLoadCwd", M.load_cwd, {})
end

return M

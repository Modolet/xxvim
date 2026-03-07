local M = {}

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
    persistence.load()
  end
end

function M.load_cwd()
  local ok, persistence = pcall(require, "persistence")
  if ok then
    persistence.load({ last = false })
  end
end

function M.recent_projects()
  local projects = {}
  local seen = {}
  for _, file in ipairs(vim.v.oldfiles) do
    local dir = vim.fn.fnamemodify(file, ":p:h")
    if dir ~= "" then
      local git = vim.fs.find(".git", { path = dir, upward = true })[1]
      local root = git and vim.fn.fnamemodify(git, ":h") or dir
      if not seen[root] then
        seen[root] = true
        table.insert(projects, root)
      end
    end
  end
  if #projects == 0 then
    vim.notify("No recent projects", vim.log.levels.INFO)
    return
  end
  Snacks.picker.select(projects, {
    prompt = "Recent Projects",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if choice then
      vim.cmd("cd " .. vim.fn.fnameescape(choice))
      Snacks.picker.files({ cwd = choice })
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

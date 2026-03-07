local workflow = {}

local state = {
  float_term = nil,
  bottom_term = nil,
}

local function create_terminal_buffer(command)
  local buffer = vim.api.nvim_create_buf(false, true)
  vim.bo[buffer].bufhidden = "hide"
  vim.bo[buffer].filetype = "terminal"
  return buffer, command or vim.o.shell
end

local function start_terminal(buffer, command)
  vim.api.nvim_buf_call(buffer, function()
    vim.fn.termopen(command)
    vim.cmd("startinsert")
  end)
end

function workflow.toggle_float_terminal(command)
  if state.float_term and vim.api.nvim_win_is_valid(state.float_term) then
    vim.api.nvim_win_close(state.float_term, true)
    state.float_term = nil
    return
  end

  local buffer, cmd = create_terminal_buffer(command)
  local width = math.floor(vim.o.columns * 0.85)
  local height = math.floor(vim.o.lines * 0.75)
  local row = math.floor((vim.o.lines - height) / 2 - 1)
  local col = math.floor((vim.o.columns - width) / 2)

  state.float_term = vim.api.nvim_open_win(buffer, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  start_terminal(buffer, cmd)
end

function workflow.toggle_bottom_terminal(command)
  if state.bottom_term and vim.api.nvim_win_is_valid(state.bottom_term) then
    vim.api.nvim_win_close(state.bottom_term, true)
    state.bottom_term = nil
    return
  end

  vim.cmd("botright 15split")
  state.bottom_term = vim.api.nvim_get_current_win()
  local buffer, cmd = create_terminal_buffer(command)
  vim.api.nvim_win_set_buf(state.bottom_term, buffer)
  start_terminal(buffer, cmd)
end

function workflow.toggle_lazygit()
  workflow.toggle_float_terminal("lazygit")
end

function workflow.close_other_buffers()
  local current = vim.api.nvim_get_current_buf()
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if buffer ~= current and vim.bo[buffer].buflisted then
      pcall(vim.api.nvim_buf_delete, buffer, { force = false })
    end
  end
end

function workflow.save_session()
  local session = vim.fn.stdpath("state") .. "/xxvim-session.vim"
  vim.cmd("mksession! " .. vim.fn.fnameescape(session))
  vim.notify("Session saved: " .. session)
end

function workflow.restore_session()
  local session = vim.fn.stdpath("state") .. "/xxvim-session.vim"
  if vim.fn.filereadable(session) == 1 then
    vim.cmd("silent! source " .. vim.fn.fnameescape(session))
    vim.notify("Session restored")
  else
    vim.notify("No saved session", vim.log.levels.WARN)
  end
end

function workflow.session_load_last()
  local ok, persistence = pcall(require, "persistence")
  if ok then
    persistence.load()
  end
end

function workflow.session_load_cwd()
  local ok, persistence = pcall(require, "persistence")
  if ok then
    persistence.load({ last = false })
  end
end

function workflow.recent_projects()
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

function workflow.git_blame_line()
  require("gitsigns").blame_line({ full = true })
end

function workflow.git_diff_this()
  vim.cmd("Gitsigns diffthis")
end

function workflow.setup_commands()
  vim.api.nvim_create_user_command("XxvimFloatTerm", function(opts)
    workflow.toggle_float_terminal(opts.args ~= "" and opts.args or nil)
  end, { nargs = "*" })

  vim.api.nvim_create_user_command("XxvimBottomTerm", function(opts)
    workflow.toggle_bottom_terminal(opts.args ~= "" and opts.args or nil)
  end, { nargs = "*" })

  vim.api.nvim_create_user_command("XxvimSessionSave", workflow.save_session, {})
  vim.api.nvim_create_user_command("XxvimSessionRestore", workflow.restore_session, {})
  vim.api.nvim_create_user_command("XxvimRecentProjects", workflow.recent_projects, {})
  vim.api.nvim_create_user_command("XxvimLazyGit", workflow.toggle_lazygit, {})
  vim.api.nvim_create_user_command("XxvimSessionLoadLast", workflow.session_load_last, {})
  vim.api.nvim_create_user_command("XxvimSessionLoadCwd", workflow.session_load_cwd, {})
end

workflow.setup_commands()
_G.xxvim_workflow = workflow

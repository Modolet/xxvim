local function terminal_module()
  return require("xxvim.terminal")
end

local function session_module()
  return require("xxvim.session")
end

local function buffers_module()
  return require("xxvim.buffers")
end

local function git_module()
  return require("xxvim.git")
end

local workflow = {
  toggle_float_terminal = function(...)
    return terminal_module().toggle_float_terminal(...)
  end,
  toggle_bottom_terminal = function(...)
    return terminal_module().toggle_bottom_terminal(...)
  end,
  toggle_lazygit = function(...)
    return terminal_module().toggle_lazygit(...)
  end,
  other_buffer = function(...)
    return buffers_module().other_buffer(...)
  end,
  delete_buffer_and_window = function(...)
    return buffers_module().delete_buffer_and_window(...)
  end,
  close_other_buffers = function(...)
    return buffers_module().close_other_buffers(...)
  end,
  save_session = function(...)
    return session_module().save_session(...)
  end,
  restore_session = function(...)
    return session_module().restore_session(...)
  end,
  session_load_last = function(...)
    return session_module().load_last(...)
  end,
  session_load_cwd = function(...)
    return session_module().load_cwd(...)
  end,
  recent_projects = function(...)
    return session_module().recent_projects(...)
  end,
  git_blame_line = function(...)
    return git_module().blame_line(...)
  end,
  git_diff_this = function(...)
    return git_module().diff_this(...)
  end,
  toggle_zoom = function(...)
    return buffers_module().toggle_zoom(...)
  end,
}

terminal_module().setup_commands()
session_module().setup_commands()
buffers_module().setup_commands()

return workflow

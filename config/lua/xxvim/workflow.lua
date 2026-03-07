local terminal = require("xxvim.terminal")
local session = require("xxvim.session")
local buffers = require("xxvim.buffers")
local git = require("xxvim.git")

local workflow = {
  toggle_float_terminal = terminal.toggle_float_terminal,
  toggle_bottom_terminal = terminal.toggle_bottom_terminal,
  toggle_lazygit = terminal.toggle_lazygit,
  other_buffer = buffers.other_buffer,
  delete_buffer_and_window = buffers.delete_buffer_and_window,
  close_other_buffers = buffers.close_other_buffers,
  save_session = session.save_session,
  restore_session = session.restore_session,
  session_load_last = session.load_last,
  session_load_cwd = session.load_cwd,
  recent_projects = session.recent_projects,
  git_blame_line = git.blame_line,
  git_diff_this = git.diff_this,
  toggle_zoom = buffers.toggle_zoom,
}

terminal.setup_commands()
session.setup_commands()
buffers.setup_commands()

return workflow

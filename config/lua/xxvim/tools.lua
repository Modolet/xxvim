local root = require("xxvim.root")
local toggle = require("xxvim.toggle")
local session = require("xxvim.session")
local tasks = require("xxvim.tasks")

root.setup_commands()
session.setup_persistence()
tasks.setup()

return {
  root = root,
  toggle = toggle,
  session = session,
  tasks = tasks,
}

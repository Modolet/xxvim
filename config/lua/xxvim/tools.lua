local root = require("xxvim.root")
local toggle = require("xxvim.toggle")
local testing = require("xxvim.testing")
local tasks = require("xxvim.tasks")

root.setup_commands()
testing.setup()
tasks.setup()

return {
  root = root,
  toggle = toggle,
  testing = testing,
  tasks = tasks,
}

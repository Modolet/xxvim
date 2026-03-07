local root = require("xxvim.root")
local toggle = require("xxvim.toggle")
local testing = require("xxvim.testing")
local tasks = require("xxvim.tasks")

_G.xxvim_root = root.project_root
_G.xxvim_toggles = toggle.state
_G.xxvim_toggle_option = toggle.toggle_option
_G.xxvim_toggle_autoformat_global = toggle.toggle_autoformat_global
_G.xxvim_toggle_autoformat_buffer = toggle.toggle_autoformat_buffer
_G.xxvim_toggle_diagnostics = toggle.toggle_diagnostics
_G.xxvim_toggle_inlay_hints = toggle.toggle_inlay_hints
_G.xxvim_toggle_conceal = toggle.toggle_conceal
_G.xxvim_toggle_tabline = toggle.toggle_tabline
_G.xxvim_toggle_background = toggle.toggle_background
_G.xxvim_toggle_indent_guides = toggle.toggle_indent_guides
_G.xxvim_toggle_treesitter_highlight = toggle.toggle_treesitter_highlight

root.setup_commands()
testing.setup()
tasks.setup()

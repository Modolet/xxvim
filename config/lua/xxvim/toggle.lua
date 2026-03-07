local M = {}

M.state = {
  autoformat = true,
  diagnostics = true,
}

local function notify_toggle(name, state)
  vim.notify(string.format("%s: %s", name, state and "on" or "off"))
end

function M.toggle_option(name, value_on, value_off, scope)
  local current = vim[scope][name]
  local next_value = current == value_on and value_off or value_on
  vim[scope][name] = next_value
  notify_toggle(name, next_value == value_on)
end

function M.toggle_autoformat_global()
  M.state.autoformat = not M.state.autoformat
  notify_toggle("autoformat(global)", M.state.autoformat)
end

function M.toggle_autoformat_buffer()
  vim.b.xxvim_autoformat = not (vim.b.xxvim_autoformat ~= false)
  notify_toggle("autoformat(buffer)", vim.b.xxvim_autoformat)
end

function M.toggle_diagnostics()
  M.state.diagnostics = not M.state.diagnostics
  vim.diagnostic.enable(M.state.diagnostics)
  notify_toggle("diagnostics", M.state.diagnostics)
end

function M.toggle_inlay_hints()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
  notify_toggle("inlay_hints", not enabled)
end

function M.toggle_conceal()
  local next_value = vim.o.conceallevel == 0 and 2 or 0
  vim.o.conceallevel = next_value
  notify_toggle("conceallevel", next_value > 0)
end

function M.toggle_tabline()
  local next_value = vim.o.showtabline == 0 and 2 or 0
  vim.o.showtabline = next_value
  notify_toggle("tabline", next_value > 0)
end

function M.toggle_background()
  vim.o.background = vim.o.background == "dark" and "light" or "dark"
  notify_toggle("background", vim.o.background == "dark")
end

function M.toggle_indent_guides()
  vim.g.xxvim_indent_guides = not (vim.g.xxvim_indent_guides ~= false)
  if vim.g.xxvim_indent_guides then
    pcall(vim.cmd, "IBLEnable")
  else
    pcall(vim.cmd, "IBLDisable")
  end
  notify_toggle("indent_guides", vim.g.xxvim_indent_guides)
end

function M.toggle_treesitter_highlight()
  vim.b.xxvim_ts_highlight = not (vim.b.xxvim_ts_highlight ~= false)
  if vim.b.xxvim_ts_highlight then
    pcall(vim.treesitter.start)
  else
    pcall(vim.treesitter.stop)
  end
  notify_toggle("treesitter_highlight", vim.b.xxvim_ts_highlight)
end

return M

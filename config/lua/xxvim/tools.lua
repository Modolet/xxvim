local function project_root()
  local current = vim.api.nvim_buf_get_name(0)
  local start = current ~= "" and vim.fs.dirname(current) or vim.loop.cwd()
  local markers = {
    ".git",
    "flake.nix",
    "Cargo.toml",
    "pyproject.toml",
    "setup.py",
    "CMakeLists.txt",
    "compile_commands.json",
    "package.json",
  }
  local found = vim.fs.find(markers, { path = start, upward = true })[1]
  if found then
    return vim.fs.dirname(found)
  end
  return vim.loop.cwd()
end

_G.xxvim_root = project_root

local toggles = {
  autoformat = true,
  diagnostics = true,
}

_G.xxvim_toggles = toggles

local function notify_toggle(name, state)
  vim.notify(string.format("%s: %s", name, state and "on" or "off"))
end

local function toggle_option(name, value_on, value_off, scope)
  local current = vim[scope][name]
  local next_value = current == value_on and value_off or value_on
  vim[scope][name] = next_value
  notify_toggle(name, next_value == value_on)
end

_G.xxvim_toggle_option = toggle_option

function _G.xxvim_toggle_autoformat_global()
  toggles.autoformat = not toggles.autoformat
  notify_toggle("autoformat(global)", toggles.autoformat)
end

function _G.xxvim_toggle_autoformat_buffer()
  vim.b.xxvim_autoformat = not (vim.b.xxvim_autoformat ~= false)
  notify_toggle("autoformat(buffer)", vim.b.xxvim_autoformat)
end

function _G.xxvim_toggle_diagnostics()
  toggles.diagnostics = not toggles.diagnostics
  vim.diagnostic.enable(toggles.diagnostics)
  notify_toggle("diagnostics", toggles.diagnostics)
end

function _G.xxvim_toggle_inlay_hints()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
  notify_toggle("inlay_hints", not enabled)
end

function _G.xxvim_toggle_conceal()
  local next_value = vim.o.conceallevel == 0 and 2 or 0
  vim.o.conceallevel = next_value
  notify_toggle("conceallevel", next_value > 0)
end

function _G.xxvim_toggle_tabline()
  local next_value = vim.o.showtabline == 0 and 2 or 0
  vim.o.showtabline = next_value
  notify_toggle("tabline", next_value > 0)
end

function _G.xxvim_toggle_background()
  vim.o.background = vim.o.background == "dark" and "light" or "dark"
  notify_toggle("background", vim.o.background == "dark")
end

function _G.xxvim_toggle_indent_guides()
  vim.g.xxvim_indent_guides = not (vim.g.xxvim_indent_guides ~= false)
  if vim.g.xxvim_indent_guides then
    pcall(vim.cmd, "IBLEnable")
  else
    pcall(vim.cmd, "IBLDisable")
  end
  notify_toggle("indent_guides", vim.g.xxvim_indent_guides)
end

function _G.xxvim_toggle_treesitter_highlight()
  vim.b.xxvim_ts_highlight = not (vim.b.xxvim_ts_highlight ~= false)
  if vim.b.xxvim_ts_highlight then
    pcall(vim.treesitter.start)
  else
    pcall(vim.treesitter.stop)
  end
  notify_toggle("treesitter_highlight", vim.b.xxvim_ts_highlight)
end

local ok_neotest, neotest = pcall(require, "neotest")
if ok_neotest then
  neotest.setup({
    adapters = {
      require("neotest-python")({
        dap = { justMyCode = false },
        runner = "pytest",
      }),
      require("neotest-rust")({}),
    },
    quickfix = {
      enabled = false,
      open = false,
    },
    output = {
      enabled = true,
      open_on_run = "short",
    },
    summary = {
      animated = true,
      follow = true,
      mappings = {
        expand = { "<CR>", "o" },
        output = "O",
        short = "s",
      },
    },
  })
end

local ok_persistence, persistence = pcall(require, "persistence")
if ok_persistence then
  persistence.setup({
    dir = vim.fn.stdpath("state") .. "/sessions/",
    options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
  })
end

local ok_overseer, overseer = pcall(require, "overseer")
if ok_overseer then
  overseer.register_template({
    name = "cargo check",
    builder = function()
      return { cmd = { "cargo" }, args = { "check" }, cwd = project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "rust" } },
  })
  overseer.register_template({
    name = "cargo clippy",
    builder = function()
      return { cmd = { "cargo" }, args = { "clippy" }, cwd = project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "rust" } },
  })
  overseer.register_template({
    name = "cargo nextest",
    builder = function()
      return { cmd = { "cargo" }, args = { "nextest", "run" }, cwd = project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "rust" } },
  })
  overseer.register_template({
    name = "cargo run",
    builder = function()
      return { cmd = { "cargo" }, args = { "run" }, cwd = project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "rust" } },
  })
  overseer.register_template({
    name = "pytest current file",
    builder = function()
      return { cmd = { "pytest" }, args = { vim.fn.expand("%") }, cwd = project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "python" } },
  })
  overseer.register_template({
    name = "python current file",
    builder = function()
      return { cmd = { "python" }, args = { vim.fn.expand("%") }, cwd = project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "python" } },
  })
  overseer.register_template({
    name = "cmake configure",
    builder = function()
      return { cmd = { "cmake", "-S", ".", "-B", "build" }, cwd = project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "c", "cpp", "cmake" } },
  })
  overseer.register_template({
    name = "cmake build",
    builder = function()
      return { cmd = { "cmake", "--build", "build" }, cwd = project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "c", "cpp", "cmake" } },
  })
end

vim.api.nvim_create_user_command("XxvimCdRoot", function()
  local root = project_root()
  vim.cmd("cd " .. vim.fn.fnameescape(root))
  vim.notify("Changed cwd to " .. root)
end, {})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local ok, persistence = pcall(require, "persistence")
    if ok then
      persistence.save()
    end
  end,
})

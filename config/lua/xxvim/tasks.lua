local M = {}

local root = require("xxvim.root")

local augroup = vim.api.nvim_create_augroup("xxvim_tasks", { clear = true })

local function current_root(bufnr)
  bufnr = bufnr or 0
  local name = vim.api.nvim_buf_get_name(bufnr)
  local start = name ~= "" and vim.fs.dirname(name) or vim.uv.cwd()
  local markers = {
    ".git",
    "flake.nix",
    "Cargo.toml",
    "pyproject.toml",
    "setup.py",
    "CMakeLists.txt",
    "CMakePresets.json",
    "compile_commands.json",
    "package.json",
  }
  local found = vim.fs.find(markers, { path = start, upward = true })[1]
  if found then
    return vim.fs.dirname(found)
  end
  return root.project_root()
end

local function has_marker(project_root, markers)
  return vim.fs.find(markers, { path = project_root, upward = false, limit = 1 })[1] ~= nil
end

local function project_kind(bufnr)
  local project_root = current_root(bufnr)
  if has_marker(project_root, { "Cargo.toml" }) then
    return "rust", project_root
  end
  if has_marker(project_root, { "CMakeLists.txt", "CMakePresets.json", "CMakeUserPresets.json" }) then
    return "cmake", project_root
  end
  if has_marker(project_root, { "pyproject.toml", "uv.lock", "setup.py", "requirements.txt" }) then
    return "python", project_root
  end
  return "generic", project_root
end

local function run_overseer(template_name)
  vim.cmd(("OverseerRun %s"):format(template_name))
end

local function run_command(command)
  vim.cmd(command)
end

local function notify_missing(feature)
  vim.notify(feature .. " 在当前项目不可用", vim.log.levels.WARN)
end

local function call_profile_action(action_name, fallback)
  local kind = project_kind(0)
  local profile = M.get_profile(kind)
  local action = profile.actions[action_name]
  if action then
    return action()
  end
  if fallback then
    return fallback()
  end
  notify_missing(profile.label)
end

function M.get_profile(kind)
  local profiles = {
    rust = {
      label = "cargo",
      group = "run/build (cargo)",
      actions = {
        primary = function()
          run_overseer("cargo run")
        end,
        check = function()
          run_overseer("cargo check")
        end,
        secondary = function()
          run_overseer("cargo clippy")
        end,
        build = function()
          run_overseer("cargo build")
        end,
        test = function()
          run_overseer("cargo test")
        end,
        extra_test = function()
          run_overseer("cargo nextest")
        end,
        picker = function()
          vim.cmd("OverseerRun")
        end,
      },
      mappings = {
        ["<leader>rc"] = { action = "check", desc = "Cargo Check" },
        ["<leader>rC"] = { action = "secondary", desc = "Cargo Clippy" },
        ["<leader>rb"] = { action = "build", desc = "Cargo Build" },
        ["<leader>rr"] = { action = "primary", desc = "Cargo Run" },
        ["<leader>rt"] = { action = "test", desc = "Cargo Test" },
        ["<leader>rT"] = { action = "extra_test", desc = "Cargo Nextest" },
        ["<leader>rR"] = { action = "picker", desc = "Cargo Tasks" },
      },
    },
    python = {
      label = "uv",
      group = "run/build (uv)",
      actions = {
        primary = function()
          run_overseer("uv run current file")
        end,
        check = function()
          run_overseer("uv sync")
        end,
        test = function()
          run_overseer("uv pytest current file")
        end,
        extra_test = function()
          run_overseer("uv pytest")
        end,
        build = function()
          run_overseer("uv run current file")
        end,
        picker = function()
          vim.cmd("OverseerRun")
        end,
      },
      mappings = {
        ["<leader>rc"] = { action = "check", desc = "UV Sync" },
        ["<leader>rb"] = { action = "build", desc = "UV Run File" },
        ["<leader>rr"] = { action = "primary", desc = "UV Run File" },
        ["<leader>rt"] = { action = "test", desc = "UV Pytest File" },
        ["<leader>rT"] = { action = "extra_test", desc = "UV Pytest Project" },
        ["<leader>rR"] = { action = "picker", desc = "UV Tasks" },
      },
    },
    cmake = {
      label = "cmake-tools",
      group = "run/build (cmake)",
      actions = {
        primary = function()
          run_command("CMakeRun")
        end,
        check = function()
          run_command("CMakeGenerate")
        end,
        secondary = function()
          run_command("CMakeSelectBuildPreset")
        end,
        build = function()
          run_command("CMakeBuild")
        end,
        test = function()
          run_command("CMakeRunTest")
        end,
        debug = function()
          run_command("CMakeDebug")
        end,
        select = function()
          run_command("CMakeSelectLaunchTarget")
        end,
        picker = function()
          run_command("CMakeSelectBuildTarget")
        end,
      },
      mappings = {
        ["<leader>rc"] = { action = "check", desc = "CMake Configure" },
        ["<leader>rC"] = { action = "secondary", desc = "CMake Build Preset" },
        ["<leader>rb"] = { action = "build", desc = "CMake Build" },
        ["<leader>rr"] = { action = "primary", desc = "CMake Run" },
        ["<leader>rt"] = { action = "test", desc = "CMake Test" },
        ["<leader>rd"] = { action = "debug", desc = "CMake Debug" },
        ["<leader>rs"] = { action = "select", desc = "CMake Launch Target" },
        ["<leader>rR"] = { action = "picker", desc = "CMake Build Target" },
      },
    },
    generic = {
      label = "tasks",
      group = "run/build",
      actions = {
        primary = function()
          vim.cmd("OverseerRun")
        end,
        picker = function()
          vim.cmd("OverseerRun")
        end,
      },
      mappings = {
        ["<leader>rr"] = { action = "primary", desc = "Tasks Picker" },
        ["<leader>rR"] = { action = "picker", desc = "Tasks Picker" },
      },
    },
  }

  return profiles[kind] or profiles.generic
end

local function register_which_key(bufnr, profile)
  local ok, which_key = pcall(require, "which-key")
  if not ok then
    return
  end

  local entries = {
    { "<leader>r", group = profile.group, buffer = bufnr },
  }

  for lhs, spec in pairs(profile.mappings) do
    table.insert(entries, { lhs, desc = spec.desc, buffer = bufnr })
  end

  which_key.add(entries)
end

function M.refresh_buffer_keymaps(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local kind = project_kind(bufnr)
  local profile = M.get_profile(kind)
  local managed_keys = {
    "<leader>rc",
    "<leader>rC",
    "<leader>rb",
    "<leader>rr",
    "<leader>rt",
    "<leader>rT",
    "<leader>rd",
    "<leader>rs",
    "<leader>rR",
  }

  for _, lhs in ipairs(managed_keys) do
    pcall(vim.keymap.del, "n", lhs, { buffer = bufnr })
  end

  for lhs, spec in pairs(profile.mappings) do
    vim.keymap.set("n", lhs, function()
      call_profile_action(spec.action)
    end, { buffer = bufnr, silent = true, desc = spec.desc })
  end

  vim.b[bufnr].xxvim_run_profile = kind
  register_which_key(bufnr, profile)
end

function M.primary()
  call_profile_action("primary", function()
    vim.cmd("OverseerRun")
  end)
end

function M.check()
  call_profile_action("check", function()
    notify_missing("check/configure")
  end)
end

function M.secondary()
  call_profile_action("secondary", function()
    notify_missing("secondary action")
  end)
end

function M.build()
  call_profile_action("build", function()
    notify_missing("build")
  end)
end

function M.test()
  call_profile_action("test", function()
    notify_missing("test")
  end)
end

function M.extra_test()
  call_profile_action("extra_test", function()
    notify_missing("extra test")
  end)
end

function M.debug()
  call_profile_action("debug", function()
    notify_missing("debug")
  end)
end

function M.select()
  call_profile_action("select", function()
    notify_missing("select")
  end)
end

function M.picker()
  call_profile_action("picker", function()
    vim.cmd("OverseerRun")
  end)
end

function M.setup_overseer_templates()
  local ok_overseer, overseer = pcall(require, "overseer")
  if not ok_overseer then
    return
  end

  local templates = {
    {
      name = "cargo check",
      cmd = { "cargo" },
      args = { "check" },
      condition = { filetype = { "rust" } },
    },
    {
      name = "cargo clippy",
      cmd = { "cargo" },
      args = { "clippy" },
      condition = { filetype = { "rust" } },
    },
    {
      name = "cargo build",
      cmd = { "cargo" },
      args = { "build" },
      condition = { filetype = { "rust" } },
    },
    {
      name = "cargo test",
      cmd = { "cargo" },
      args = { "test" },
      condition = { filetype = { "rust" } },
    },
    {
      name = "cargo nextest",
      cmd = { "cargo" },
      args = { "nextest", "run" },
      condition = { filetype = { "rust" } },
    },
    {
      name = "cargo run",
      cmd = { "cargo" },
      args = { "run" },
      condition = { filetype = { "rust" } },
    },
    {
      name = "uv sync",
      cmd = { "uv" },
      args = { "sync" },
      condition = { filetype = { "python" } },
    },
    {
      name = "uv run current file",
      cmd = { "uv" },
      args = function()
        return { "run", vim.fn.expand("%:.") }
      end,
      condition = { filetype = { "python" } },
    },
    {
      name = "uv pytest current file",
      cmd = { "uv" },
      args = function()
        return { "run", "pytest", vim.fn.expand("%:.") }
      end,
      condition = { filetype = { "python" } },
    },
    {
      name = "uv pytest",
      cmd = { "uv" },
      args = { "run", "pytest" },
      condition = { filetype = { "python" } },
    },
  }

  for _, template in ipairs(templates) do
    overseer.register_template({
      name = template.name,
      builder = function()
        local args = type(template.args) == "function" and template.args() or template.args
        return {
          cmd = template.cmd,
          args = args,
          cwd = current_root(),
          components = { { "default" } },
        }
      end,
      condition = template.condition,
    })
  end
end

function M.setup_dynamic_keymaps()
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "DirChanged" }, {
    group = augroup,
    callback = function(event)
      M.refresh_buffer_keymaps(event.buf)
    end,
  })
end

function M.setup()
  M.setup_overseer_templates()
  M.setup_dynamic_keymaps()
end

return M

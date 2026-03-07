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
      return {
        cmd = { "cargo" },
        args = { "check" },
        cwd = project_root(),
        components = { { "default" } },
      }
    end,
    condition = { filetype = { "rust" } },
  })

  overseer.register_template({
    name = "cargo clippy",
    builder = function()
      return {
        cmd = { "cargo" },
        args = { "clippy" },
        cwd = project_root(),
        components = { { "default" } },
      }
    end,
    condition = { filetype = { "rust" } },
  })

  overseer.register_template({
    name = "cargo nextest",
    builder = function()
      return {
        cmd = { "cargo" },
        args = { "nextest", "run" },
        cwd = project_root(),
        components = { { "default" } },
      }
    end,
    condition = { filetype = { "rust" } },
  })

  overseer.register_template({
    name = "cargo run",
    builder = function()
      return {
        cmd = { "cargo" },
        args = { "run" },
        cwd = project_root(),
        components = { { "default" } },
      }
    end,
    condition = { filetype = { "rust" } },
  })

  overseer.register_template({
    name = "pytest current file",
    builder = function()
      return {
        cmd = { "pytest" },
        args = { vim.fn.expand("%") },
        cwd = project_root(),
        components = { { "default" } },
      }
    end,
    condition = { filetype = { "python" } },
  })

  overseer.register_template({
    name = "python current file",
    builder = function()
      return {
        cmd = { "python" },
        args = { vim.fn.expand("%") },
        cwd = project_root(),
        components = { { "default" } },
      }
    end,
    condition = { filetype = { "python" } },
  })

  overseer.register_template({
    name = "cmake configure",
    builder = function()
      return {
        cmd = { "cmake", "-S", ".", "-B", "build" },
        cwd = project_root(),
        components = { { "default" } },
      }
    end,
    condition = { filetype = { "c", "cpp", "cmake" } },
  })

  overseer.register_template({
    name = "cmake build",
    builder = function()
      return {
        cmd = { "cmake", "--build", "build" },
        cwd = project_root(),
        components = { { "default" } },
      }
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

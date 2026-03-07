local M = {}

local root = require("xxvim.root")

function M.setup_overseer_templates()
  local ok_overseer, overseer = pcall(require, "overseer")
  if not ok_overseer then
    return
  end

  overseer.register_template({
    name = "cargo check",
    builder = function()
      return { cmd = { "cargo" }, args = { "check" }, cwd = root.project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "rust" } },
  })
  overseer.register_template({
    name = "cargo clippy",
    builder = function()
      return { cmd = { "cargo" }, args = { "clippy" }, cwd = root.project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "rust" } },
  })
  overseer.register_template({
    name = "cargo nextest",
    builder = function()
      return { cmd = { "cargo" }, args = { "nextest", "run" }, cwd = root.project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "rust" } },
  })
  overseer.register_template({
    name = "cargo run",
    builder = function()
      return { cmd = { "cargo" }, args = { "run" }, cwd = root.project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "rust" } },
  })
  overseer.register_template({
    name = "pytest current file",
    builder = function()
      return { cmd = { "pytest" }, args = { vim.fn.expand("%") }, cwd = root.project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "python" } },
  })
  overseer.register_template({
    name = "python current file",
    builder = function()
      return { cmd = { "python" }, args = { vim.fn.expand("%") }, cwd = root.project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "python" } },
  })
  overseer.register_template({
    name = "cmake configure",
    builder = function()
      return { cmd = { "cmake", "-S", ".", "-B", "build" }, cwd = root.project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "c", "cpp", "cmake" } },
  })
  overseer.register_template({
    name = "cmake build",
    builder = function()
      return { cmd = { "cmake", "--build", "build" }, cwd = root.project_root(), components = { { "default" } } }
    end,
    condition = { filetype = { "c", "cpp", "cmake" } },
  })
end

function M.setup()
  M.setup_overseer_templates()
end

return M

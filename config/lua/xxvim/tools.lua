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
    name = "cargo build",
    builder = function()
      return {
        cmd = { "cargo" },
        args = { "build" },
        components = { { "default" } },
      }
    end,
    condition = {
      filetype = { "rust" },
    },
  })

  overseer.register_template({
    name = "cargo test",
    builder = function()
      return {
        cmd = { "cargo" },
        args = { "test" },
        components = { { "default" } },
      }
    end,
    condition = {
      filetype = { "rust" },
    },
  })

  overseer.register_template({
    name = "pytest current file",
    builder = function()
      return {
        cmd = { "pytest" },
        args = { vim.fn.expand("%") },
        components = { { "default" } },
      }
    end,
    condition = {
      filetype = { "python" },
    },
  })

  overseer.register_template({
    name = "cmake build",
    builder = function()
      return {
        cmd = { "cmake", "--build", "build" },
        components = { { "default" } },
      }
    end,
    condition = {
      filetype = { "c", "cpp", "cmake" },
    },
  })
end

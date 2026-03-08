local M = {}

local neotest_ready = false
local persistence_ready = false

function M.ensure_neotest()
  if neotest_ready then
    return true, require("neotest")
  end

  local ok_neotest, neotest = pcall(require, "neotest")
  if not ok_neotest then
    return false
  end

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

  neotest_ready = true
  return true, neotest
end

function M.ensure_persistence()
  if persistence_ready then
    return true, require("persistence")
  end

  local ok_persistence, persistence = pcall(require, "persistence")
  if not ok_persistence then
    return false
  end

  persistence.setup({
    dir = vim.fn.stdpath("state") .. "/sessions/",
    options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
  })

  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      local ok, persistence_module = pcall(require, "persistence")
      if ok then
        persistence_module.save()
      end
    end,
  })

  persistence_ready = true
  return true, persistence
end

function M.run_nearest()
  local ok, neotest = M.ensure_neotest()
  if ok then
    neotest.run.run()
  end
end

function M.run_file()
  local ok, neotest = M.ensure_neotest()
  if ok then
    neotest.run.run(vim.fn.expand("%"))
  end
end

function M.toggle_summary()
  local ok, neotest = M.ensure_neotest()
  if ok then
    neotest.summary.toggle()
  end
end

function M.open_output()
  local ok, neotest = M.ensure_neotest()
  if ok then
    neotest.output.open({ enter = true, auto_close = true })
  end
end

function M.debug_nearest()
  local ok, neotest = M.ensure_neotest()
  if ok then
    neotest.run.run({ strategy = "dap" })
  end
end

function M.setup()
  M.ensure_persistence()
end

return M

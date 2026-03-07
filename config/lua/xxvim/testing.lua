local M = {}

function M.setup_neotest()
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
end

function M.setup_persistence()
  local ok_persistence, persistence = pcall(require, "persistence")
  if ok_persistence then
    persistence.setup({
      dir = vim.fn.stdpath("state") .. "/sessions/",
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
    })
  end

  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      local ok, persistence_module = pcall(require, "persistence")
      if ok then
        persistence_module.save()
      end
    end,
  })
end

function M.setup()
  M.setup_neotest()
  M.setup_persistence()
end

return M

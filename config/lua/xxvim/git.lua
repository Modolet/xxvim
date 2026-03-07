local M = {}

function M.blame_line()
  require("gitsigns").blame_line({ full = true })
end

function M.diff_this()
  vim.cmd("Gitsigns diffthis")
end

return M

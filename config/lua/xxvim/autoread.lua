local M = {}

local group_name = "xxvim_autoread"

local function can_checktime()
  return vim.fn.mode() ~= "c"
end

function M.checktime()
  if not can_checktime() then
    return
  end

  vim.cmd("silent! checktime")
end

function M.setup()
  vim.opt.autoread = true

  local group = vim.api.nvim_create_augroup(group_name, { clear = true })

  vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermLeave" }, {
    group = group,
    callback = M.checktime,
    desc = "Check for external file changes",
  })

  vim.api.nvim_create_autocmd("FileChangedShellPost", {
    group = group,
    callback = function(args)
      local name = vim.api.nvim_buf_get_name(args.buf)
      if name == "" then
        return
      end

      vim.notify(
        "Reloaded external changes: " .. vim.fn.fnamemodify(name, ":~:."),
        vim.log.levels.INFO,
        { title = "xxvim" }
      )
    end,
    desc = "Notify when an external file change is reloaded",
  })
end

return M

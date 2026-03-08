local module = {}

function module.rename()
  vim.cmd("IncRename " .. vim.fn.expand("<cword>"))
end

return module

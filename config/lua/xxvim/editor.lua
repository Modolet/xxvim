local ok_yanky, yanky = pcall(require, "yanky")
if ok_yanky then
  yanky.setup({
    ring = { history_length = 100 },
    picker = { select = { action = nil } },
  })
end

local ok_dial, dial = pcall(require, "dial.config")
if ok_dial then
  vim.keymap.set("n", "<C-a>", function()
    require("dial.map").manipulate("increment", "normal")
  end)
  vim.keymap.set("n", "<C-x>", function()
    require("dial.map").manipulate("decrement", "normal")
  end)
end

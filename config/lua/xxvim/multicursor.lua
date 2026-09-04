--- @file multicursor.lua
--- @brief 配置多光标编辑及其快捷键
--- @author modolet <y@xxyx.io>
--- @date 2026-09-04

local M = {}

function M.setup()
  local mc = require("multicursor-nvim")
  mc.setup()

  local map = vim.keymap.set
  local modes = { "n", "x" }

  map(modes, "<A-n>", function()
    mc.matchAddCursor(1)
  end, { desc = "Add Next Match Cursor" })
  map(modes, "<A-p>", function()
    mc.matchAddCursor(-1)
  end, { desc = "Add Previous Match Cursor" })
  map(modes, "<A-a>", mc.matchAllAddCursors, { desc = "Add All Match Cursors" })
  map(modes, "<A-s>", function()
    mc.matchSkipCursor(1)
  end, { desc = "Skip Next Match" })
  map(modes, "<A-S>", function()
    mc.matchSkipCursor(-1)
  end, { desc = "Skip Previous Match" })
  map(modes, "<A-j>", function()
    mc.lineAddCursor(1)
  end, { desc = "Add Cursor Below" })
  map(modes, "<A-k>", function()
    mc.lineAddCursor(-1)
  end, { desc = "Add Cursor Above" })
  map(modes, "<A-q>", mc.toggleCursor, { desc = "Toggle Main Cursor" })
  map("n", "<A-r>", mc.restoreCursors, { desc = "Restore Cursors" })

  map("n", "<A-LeftMouse>", mc.handleMouse, { desc = "Add or Remove Cursor" })
  map("n", "<A-LeftDrag>", mc.handleMouseDrag)
  map("n", "<A-LeftRelease>", mc.handleMouseRelease)

  mc.addKeymapLayer(function(layer_map)
    layer_map(modes, "<A-x>", mc.deleteCursor)
    layer_map("n", "<Esc>", function()
      if mc.cursorsEnabled() then
        mc.clearCursors()
      else
        mc.enableCursors()
      end
    end)
  end)

  local highlight = vim.api.nvim_set_hl
  highlight(0, "MultiCursorCursor", { reverse = true })
  highlight(0, "MultiCursorVisual", { link = "Visual" })
  highlight(0, "MultiCursorSign", { link = "SignColumn" })
  highlight(0, "MultiCursorMatchPreview", { link = "Search" })
  highlight(0, "MultiCursorDisabledCursor", { reverse = true })
  highlight(0, "MultiCursorDisabledVisual", { link = "Visual" })
  highlight(0, "MultiCursorDisabledSign", { link = "SignColumn" })
end

return M

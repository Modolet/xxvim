local has_alpha, alpha = pcall(require, "alpha")
local has_dashboard, dashboard = pcall(require, "alpha.themes.dashboard")
if has_alpha and has_dashboard then
  dashboard.section.header.val = {
    "          ██╗  ██╗██╗  ██╗██╗   ██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗          Z",
    "          ╚██╗██╔╝╚██╗██╔╝╚██╗ ██╔╝╚██╗██╔╝██║   ██║██║████╗ ████║      Z    ",
    "           ╚███╔╝  ╚███╔╝  ╚████╔╝  ╚███╔╝ ██║   ██║██║██╔████╔██║   z       ",
    "           ██╔██╗  ██╔██╗   ╚██╔╝   ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║ z         ",
    "          ██╔╝ ██╗██╔╝ ██╗   ██║   ██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║           ",
    "          ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝           ",
  }
  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find File", "<cmd>lua Snacks.picker.files({ cwd = xxvim_root() })<cr>"),
    dashboard.button("n", "  New File", "<cmd>ene<cr>"),
    dashboard.button("p", "  Projects", "<cmd>XxvimRecentProjects<cr>"),
    dashboard.button("g", "  Find Text", "<cmd>lua Snacks.picker.grep({ cwd = xxvim_root() })<cr>"),
    dashboard.button("r", "  Recent Files", "<cmd>lua Snacks.picker.recent()<cr>"),
    dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
  }

  local started = vim.g.xxvim_start_time or vim.uv.hrtime()
  local elapsed = (vim.uv.hrtime() - started) / 1000000
  dashboard.section.footer.val = string.format("⚡ Neovim loaded in %.2f ms", elapsed)

  dashboard.section.header.opts = vim.tbl_extend("force", dashboard.section.header.opts or {}, { position = "center" })
  dashboard.section.buttons.opts = vim.tbl_extend("force", dashboard.section.buttons.opts or {}, { position = "center", spacing = 1 })
  dashboard.section.footer.opts = vim.tbl_extend("force", dashboard.section.footer.opts or {}, { position = "center" })

  for _, button in ipairs(dashboard.section.buttons.val) do
    local shortcut = button.shortcut or (button.opts and button.opts.shortcut) or ""
    button.opts = vim.tbl_extend("force", button.opts or {}, {
      position = "center",
      shortcut = shortcut ~= "" and (" " .. shortcut .. " ") or shortcut,
      cursor = 5,
      width = 42,
      align_shortcut = "right",
      hl_shortcut = "Keyword",
    })
  end

  local function pad()
    local header_h = #dashboard.section.header.val
    local buttons_h = #dashboard.section.buttons.val
    local footer_h = type(dashboard.section.footer.val) == "table" and #dashboard.section.footer.val or 1
    local content_h = header_h + buttons_h + footer_h + 4
    return math.max(2, math.floor((vim.o.lines - content_h) * 0.35))
  end

  dashboard.config.layout = {
    { type = "padding", val = pad() },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    dashboard.section.footer,
  }

  vim.api.nvim_create_autocmd("VimResized", {
    callback = function()
      pcall(vim.cmd.AlphaRedraw)
    end,
  })

  alpha.setup(dashboard.config)
end

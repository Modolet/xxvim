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
    dashboard.button("f", "  Find File", "<cmd>lua Snacks.picker.files()<cr>"),
    dashboard.button("n", "  New File", "<cmd>ene<cr>"),
    dashboard.button("p", "  Projects", "<cmd>XxvimRecentProjects<cr>"),
    dashboard.button("g", "  Find Text", "<cmd>lua Snacks.picker.grep()<cr>"),
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

local has_snacks, snacks = pcall(require, "snacks")
if has_snacks then
  snacks.setup({
    picker = {
      enabled = true,
      sources = {
        files = { hidden = true },
        grep = { hidden = true },
        explorer = { hidden = true },
      },
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          },
        },
      },
    },
    explorer = { enabled = true, replace_netrw = true },
    notifier = { enabled = true, timeout = 3000 },
    quickfile = { enabled = true },
    indent = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  })
end

local has_which_key, which_key = pcall(require, "which-key")
if has_which_key then
  which_key.setup({
    preset = "modern",
    delay = 200,
    icons = { mappings = true },
  })

  which_key.add({
    { "<leader>b", group = "buffer" },
    { "<leader>c", group = "code" },
    { "<leader>d", group = "debug" },
    { "<leader>f", group = "file/find" },
    { "<leader>g", group = "git" },
    { "<leader>q", group = "quit/session" },
    { "<leader>s", group = "search" },
    { "<leader>t", group = "terminal" },
    { "<leader>w", group = "windows" },
    { "<leader>x", group = "diagnostics/quickfix" },
  })
end

local has_gitsigns, gitsigns = pcall(require, "gitsigns")
if has_gitsigns then
  gitsigns.setup({
    current_line_blame = true,
    signs_staged_enable = true,
  })
end

local has_ibl, ibl = pcall(require, "ibl")
if has_ibl then
  ibl.setup({
    indent = { char = "▏" },
    scope = { enabled = true },
  })
end

local has_lualine, lualine = pcall(require, "lualine")
if has_lualine then
  lualine.setup({
    options = {
      theme = "catppuccin",
      globalstatus = true,
      section_separators = { left = "", right = "" },
      component_separators = { left = "│", right = "│" },
    },
  })
end

local has_bufferline, bufferline = pcall(require, "bufferline")
if has_bufferline then
  bufferline.setup({
    options = {
      mode = "buffers",
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      separator_style = "slant",
      offsets = {
        {
          filetype = "snacks_layout_box",
          text = "Explorer",
          separator = true,
        },
      },
    },
  })
end

vim.opt.laststatus = 3

local has_alpha, alpha = pcall(require, "alpha")
local has_dashboard, dashboard = pcall(require, "alpha.themes.dashboard")
if has_alpha and has_dashboard then
  dashboard.section.header.val = {
    "██   ██ ██   ██ ██    ██ ██ ███    ███",
    " ██ ██   ██ ██  ██    ██ ██ ████  ████",
    "  ███     ███   ██    ██ ██ ██ ████ ██",
    " ██ ██   ██ ██   ██  ██  ██ ██  ██  ██",
    "██   ██ ██   ██   ████   ██ ██      ██",
    "",
    "              xxvim / LazyVim style",
  }
  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", "<cmd>lua Snacks.picker.files()<cr>"),
    dashboard.button("n", "  New file", "<cmd>ene<cr>"),
    dashboard.button("r", "  Recent files", "<cmd>lua Snacks.picker.recent()<cr>"),
    dashboard.button("g", "  Find text", "<cmd>lua Snacks.picker.grep()<cr>"),
    dashboard.button("p", "  Projects", "<cmd>XxvimRecentProjects<cr>"),
    dashboard.button("c", "  Config", "<cmd>lua Snacks.picker.files({cwd = vim.fn.stdpath('config')})<cr>"),
    dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
  }
  dashboard.section.footer.val = "Built with nixvim + flake"
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
    spec = {
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debug" },
      { "<leader>f", group = "find/file" },
      { "<leader>g", group = "git" },
      { "<leader>s", group = "search/symbol" },
      { "<leader>x", group = "diagnostics" },
      { "<leader>t", group = "terminal" },
      { "<leader>w", group = "window" },
      { "<leader>b", group = "buffer" },
      { "<leader>q", group = "session" },
    },
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

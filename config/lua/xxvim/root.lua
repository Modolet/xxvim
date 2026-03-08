local M = {}

local root_markers = {
  ".git",
  "flake.nix",
  "Cargo.toml",
  "rust-project.json",
  "pyproject.toml",
  "uv.lock",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "CMakeLists.txt",
  "CMakePresets.json",
  "CMakeUserPresets.json",
  "Doxyfile",
  "Doxyfile.in",
  "compile_commands.json",
  "package.json",
  "tsconfig.json",
  "jsconfig.json",
  "vite.config.ts",
  "vite.config.js",
  "pnpm-workspace.yaml",
  "tailwind.config.js",
  "tailwind.config.ts",
  "tailwind.config.cjs",
  "tailwind.config.mjs",
  "deno.json",
  "deno.jsonc",
  "default.nix",
  "shell.nix",
}

local function normalize_dir(path)
  if not path or path == "" then
    return nil
  end

  local stat = vim.uv.fs_stat(path)
  if stat and stat.type == "directory" then
    return vim.fs.normalize(path)
  end

  return vim.fs.normalize(vim.fs.dirname(path))
end

function M.detect(path)
  local start = normalize_dir(path) or vim.uv.cwd()
  local found = vim.fs.find(root_markers, { path = start, upward = true })[1]
  if found then
    return vim.fs.dirname(found)
  end
  return start
end

function M.project_root()
  local current = vim.api.nvim_buf_get_name(0)
  return M.detect(current ~= "" and current or vim.uv.cwd())
end

function M.set_cwd(path, opts)
  opts = opts or {}
  local root = M.detect(path)
  local cmd = opts.global and "cd" or "lcd"
  vim.cmd(cmd .. " " .. vim.fn.fnameescape(root))
  if not opts.silent then
    vim.notify("Changed cwd to " .. root)
  end
  return root
end

function M.cd_root()
  M.set_cwd(M.project_root(), { global = true })
end

function M.sync_startup_cwd()
  local argc = vim.fn.argc(-1)
  if argc == 0 then
    return
  end

  local first = vim.fn.argv(0)
  if not first or first == "" then
    return
  end

  local path = vim.fn.fnamemodify(first, ":p")
  local stat = vim.uv.fs_stat(path)
  if not stat then
    return
  end

  if stat.type == "directory" then
    M.set_cwd(path, { global = true, silent = true })
    return
  end

  if argc == 1 then
    M.set_cwd(path, { global = true, silent = true })
  end
end

function M.setup_commands()
  if vim.g.xxvim_root_setup_done then
    return
  end
  vim.g.xxvim_root_setup_done = true

  vim.api.nvim_create_user_command("XxvimCdRoot", M.cd_root, {})

  local group = vim.api.nvim_create_augroup("xxvim_root", { clear = true })
  if vim.v.vim_did_enter == 1 then
    M.sync_startup_cwd()
    return
  end

  vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    callback = function()
      M.sync_startup_cwd()
    end,
  })
end

return M

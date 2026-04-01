# xxvim 外部环境优先路径实现计划

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 让 xxvim 在终端、LSP、格式化等场景下优先使用外部 shell/devshell 中已有的工具，不存在时再回退到 xxvim 自带工具。

**Architecture:** 保留 nixvim 包装器注入的工具集作为兜底路径，同时把最终聚合后的 `extraPackages` 路径通过环境变量暴露给 Neovim。启动早期用 Lua 重排 `PATH`，将这些兜底路径移到末尾，从而实现“外部优先，内置回退”。

**Tech Stack:** Nix flakes, NixVim, Lua

---

### Task 1: 暴露兜底工具路径

**Files:**
- Modify: `config/core/options.nix`

**Step 1: 写入包装器环境变量**

在 NixVim wrapper 中设置 `XXVIM_TOOL_FALLBACK_PATH`，值为聚合后的 `config.extraPackages` 对应的 bin 路径。

**Step 2: 保留启动期执行点**

在 `extraConfigLuaPre` 中调用 Lua 助手，尽量在插件初始化前完成 `PATH` 重排。

### Task 2: 启动期重排 PATH

**Files:**
- Create: `config/lua/xxvim/env.lua`
- Modify: `config/core/runtime.nix`

**Step 1: 新增 Lua 助手**

实现 `setup_path_precedence()`：
- 读取 `vim.env.PATH`
- 读取 `vim.env.XXVIM_TOOL_FALLBACK_PATH`
- 从当前 `PATH` 中移除兜底路径
- 将兜底路径追加到末尾

**Step 2: 将 Lua 文件打包进运行时**

把 `env.lua` 加入 `config.extraFiles`。

### Task 3: 验证行为与回归

**Files:**
- Verify: `flake.nix`
- Verify: `config/core/options.nix`
- Verify: `config/core/runtime.nix`
- Verify: `config/lua/xxvim/env.lua`

**Step 1: 运行 flake 检查**

Run: `nix flake check`

**Step 2: 运行 headless 启动检查**

Run: `nix run .#xxvim -- --headless '+qa'`

**Step 3: 验证 PATH 重排逻辑**

Run: `nix run .#xxvim -- --headless '+lua print(vim.env.PATH)' '+qa'`

确认 xxvim 自带工具路径不再固定占据 PATH 前缀。

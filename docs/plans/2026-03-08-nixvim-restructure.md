# xxvim 配置重构 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 将 `xxvim` 从聚合式配置重构为分层模块结构，在保持现有行为基本稳定的前提下提升可维护性。

**Architecture:** 使用 `core / plugins / lang / keymaps / lua runtime` 五层结构重组现有配置。优先迁移静态 Nix 配置，再拆分 Lua 运行时，最后同步入口与 keymap 调用方式，确保行为兼容与验证闭环。

**Tech Stack:** Nix flakes、nixvim、Lua、Neovim 插件配置

---

### Task 1: 建立模块骨架与入口聚合

**Files:**
- Create: `config/core/default.nix`
- Create: `config/plugins/default.nix`
- Create: `config/lang/default.nix`
- Create: `config/keymaps/default.nix`
- Modify: `config/default.nix`

**Step 1: 写出最小可迁移目录骨架**

- 新建四个 `default.nix` 聚合入口。
- 先保持原行为不变，避免同时大规模挪动内容。

**Step 2: 调整总入口只保留 imports**

- 将 `config/default.nix` 收敛为导入 `core/plugins/lang/keymaps` 四层。

**Step 3: 运行基础验证**

Run: `nix flake check`
Expected: 配置仍可求值。

**Step 4: Commit**

```bash
git add config/default.nix config/core/default.nix config/plugins/default.nix config/lang/default.nix config/keymaps/default.nix
git commit -m "refactor: 建立配置分层骨架"
```

### Task 2: 迁移 core / plugin / lang 静态配置

**Files:**
- Create: `config/core/options.nix`
- Create: `config/core/theme.nix`
- Create: `config/core/packages.nix`
- Create: `config/plugins/*.nix`
- Create: `config/lang/*.nix`
- Modify: `config/core/default.nix`
- Modify: `config/plugins/default.nix`
- Modify: `config/lang/default.nix`

**Step 1: 先迁移纯静态模块**

- 将 `core.nix`、`theme.nix` 中的内容迁入 `core/`。
- 将 `ui.nix`、`coding.nix`、`dap.nix`、`tools.nix`、`languages.nix` 中适合静态表达的插件配置下沉到对应 plugin 文件。
- 将语言依赖与 server 配置迁到 `lang/`。

**Step 2: 保留兼容行为**

- Lua 文件先不大改，只调整引用位置。
- 能不动 keymap 就先不动 keymap。

**Step 3: 运行验证**

Run: `nix flake check`
Expected: 所有模块求值通过。

**Step 4: Commit**

```bash
git add config/core config/plugins config/lang
git commit -m "refactor: 拆分核心与插件语言模块"
```

### Task 3: 拆分 Lua 运行时模块

**Files:**
- Create: `config/lua/xxvim/root.lua`
- Create: `config/lua/xxvim/toggle.lua`
- Create: `config/lua/xxvim/terminal.lua`
- Create: `config/lua/xxvim/session.lua`
- Create: `config/lua/xxvim/buffers.lua`
- Create: `config/lua/xxvim/git.lua`
- Create: `config/lua/xxvim/dashboard.lua`
- Modify: `config/lua/xxvim/tools.lua`
- Modify: `config/lua/xxvim/workflow.lua`
- Modify: `config/lua/xxvim/dap.lua`

**Step 1: 先抽公共 root / toggle**

- 提供可 `require` 的 Lua 模块接口。
- 为旧 `_G` 入口保留兼容层，避免 keymap 同步前即断裂。

**Step 2: 再拆 workflow 逻辑**

- 将 terminal/session/buffers/git 拆分。
- 将 `ui.lua` 重命名或转移为 `dashboard.lua`。

**Step 3: 运行 headless 验证**

Run: `nix run .#xxvim -- --headless '+qa'`
Expected: 启动成功，无 require 路径错误。

**Step 4: Commit**

```bash
git add config/lua/xxvim
git commit -m "refactor: 拆分运行时 lua 模块"
```

### Task 4: 拆分 keymaps 并收口调用入口

**Files:**
- Create: `config/keymaps/*.nix`
- Modify: `config/keymaps/default.nix`
- Modify: `config/keymaps.nix`
- Modify: `README.md`

**Step 1: 按主题迁移 keymaps**

- 将现有大文件拆为多个领域文件。
- 删除旧大文件或改为兼容导入入口。

**Step 2: 同步 README 中最明显漂移项**

- 修正重命名、session 等已知不一致项。

**Step 3: 运行完整验证**

Run: `nix flake check && nix run .#xxvim -- --headless '+qa'`
Expected: 求值和 headless 启动均通过。

**Step 4: Commit**

```bash
git add config/keymaps README.md
git commit -m "refactor: 拆分按键映射并同步文档"
```

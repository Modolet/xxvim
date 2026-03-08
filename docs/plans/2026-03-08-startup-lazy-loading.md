# xxvim 冷启动懒加载优化 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 通过懒加载非首屏必需插件，优化 `xxvim` 的冷启动速度，同时保持核心编辑能力可用。

**Architecture:** 维持现有 `config/plugins/*.nix` 与 `config/lua/xxvim/*.lua` 的分层结构，把纯 UI、测试、调试、任务面板和搜索替换等能力改成 `event`、`cmd`、`keys` 驱动的按需加载。同步梳理启动期的 `require(...)` 调用，避免因过早引用破坏懒加载效果。

**Tech Stack:** Nix flakes、nixvim、Neovim Lua、lazy.nvim 兼容插件规范、snacks.nvim、trouble.nvim、nvim-dap、neotest、overseer.nvim。

---

### Task 1: 盘点启动期热点与依赖入口

**Files:**
- Modify: `config/plugins/appearance.nix`
- Modify: `config/plugins/editing.nix`
- Modify: `config/plugins/testing.nix`
- Modify: `config/plugins/dap.nix`
- Modify: `config/plugins/overseer.nix`
- Modify: `config/lua/xxvim/workflow.lua`
- Modify: `config/lua/xxvim/tools.lua`
- Modify: `config/lua/xxvim/dap.lua`
- Modify: `config/lua/xxvim/testing.lua`

**Step 1:** 标记所有启动期直接初始化的界面/工作流插件
**Step 2:** 找出启动时会直接 `require(...)` 这些插件的 Lua 入口
**Step 3:** 记录每个插件适合使用的触发方式：`event`、`cmd`、`keys` 或 `ft`
**Step 4:** 运行一次 `nix run .#xxvim -- --headless '+qa'` 建立基线
**Step 5:** 提交阶段性变更

### Task 2: 后置界面增强插件

**Files:**
- Modify: `config/plugins/appearance.nix`
- Modify: `config/plugins/alpha.nix`
- Modify: `config/lua/xxvim/ui.lua`
- Modify: `config/lua/xxvim/dashboard.lua`

**Step 1:** 将 `which-key`、`trouble`、`todo-comments`、`flash` 改为按事件/命令/按键加载
**Step 2:** 评估并后置 `noice`、`notify`、`bufferline`、`gitsigns`、`indent-blankline` 中的非首屏必需部分
**Step 3:** 检查 `snacks` 配置，优先延后非核心子模块与动画型能力
**Step 4:** 运行 `nix flake check`
**Step 5:** 运行 `nix run .#xxvim -- --headless '+qa'`
**Step 6:** 提交阶段性变更

### Task 3: 后置工具与搜索替换工作流

**Files:**
- Modify: `config/plugins/editing.nix`
- Modify: `config/plugins/overseer.nix`
- Modify: `config/lua/xxvim/workflow.lua`
- Modify: `config/lua/xxvim/tools.lua`
- Modify: `config/lua/xxvim/root.lua`

**Step 1:** 将 `grug-far` 改为通过 `XxvimSearchReplace` 命令首次触发加载
**Step 2:** 将 `overseer`、`cmake-tools` 改为命令或相关键位触发加载
**Step 3:** 确保项目根目录、任务运行入口在插件未加载前不会报错
**Step 4:** 运行 `nix flake check`
**Step 5:** 运行 `nix run .#xxvim -- --headless '+qa'`
**Step 6:** 提交阶段性变更

### Task 4: 后置测试与调试工作流

**Files:**
- Modify: `config/plugins/testing.nix`
- Modify: `config/plugins/dap.nix`
- Modify: `config/keymaps/debug_test_terminal.nix`
- Modify: `config/lua/xxvim/testing.lua`
- Modify: `config/lua/xxvim/dap.lua`

**Step 1:** 将 `neotest` 及其适配器改为按测试命令或测试键位加载
**Step 2:** 将 `dap-ui`、`dap-virtual-text` 改为调试动作首次触发加载
**Step 3:** 验证测试与调试键位首次使用时能自动拉起依赖插件
**Step 4:** 运行 `nix flake check`
**Step 5:** 运行 `nix run .#xxvim -- --headless '+qa'`
**Step 6:** 提交阶段性变更

### Task 5: 收尾验证与文档同步

**Files:**
- Modify: `README.md`
- Modify: `docs/plans/2026-03-08-startup-lazy-loading-design.md`
- Modify: `docs/plans/2026-03-08-startup-lazy-loading.md`

**Step 1:** 补充 README 中关于懒加载取舍的必要说明
**Step 2:** 执行最终 `nix flake check`
**Step 3:** 执行最终 `nix run .#xxvim -- --headless '+qa'`
**Step 4:** 手动确认 `nix run .#xxvim` 首屏正常、常用懒加载入口可用
**Step 5:** `git add README.md docs/plans/2026-03-08-startup-lazy-loading-design.md docs/plans/2026-03-08-startup-lazy-loading.md config/ && git commit -m "feat: 优化 xxvim 冷启动懒加载策略"`

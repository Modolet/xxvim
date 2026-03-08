# Rust 运行映射与 Doxygen 支持 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 修复 Rust 项目 `<leader>r` 模板映射错误，并补充 Doxygen 的基础支持与编辑支持。

**Architecture:** 在 `xxvim.tasks` 中将动作名与 Overseer 模板名彻底解耦，避免动态键位把裸动作名误传给模板层。Doxygen 支持分两层加入：root 检测与构建任务属于运行层，注释编辑体验属于 C/C++ 编辑层。

**Tech Stack:** NixVim, Neovim Lua, overseer.nvim, C/C++, Doxygen

---

### Task 1: 修复 Rust 动态运行映射

**Files:**
- Modify: `config/lua/xxvim/tasks.lua`

**Step 1:** 复查 Rust profile 的 action 与模板调用路径。
**Step 2:** 让各 action 固定调用完整模板名，如 `cargo check`、`cargo build`。
**Step 3:** 保持 Python/CMake 的动态映射行为不变。
**Step 4:** 运行 headless Lua 探针验证 profile 分发与方法调用。
**Step 5:** 提交。

### Task 2: 增加 Doxygen 基础支持

**Files:**
- Modify: `config/lua/xxvim/root.lua`
- Modify: `config/lua/xxvim/tasks.lua`
- Modify: `config/lang/docs.nix`
- Modify: `config/lang/c_cpp.nix`

**Step 1:** 在 root 检测加入 `Doxyfile` / `Doxyfile.in`。
**Step 2:** 增加 `doxygen` 运行包与 Overseer 模板。
**Step 3:** 在合适 profile 下暴露文档构建入口。
**Step 4:** 运行 headless 验证模板已注册。
**Step 5:** 提交。

### Task 3: 增加 Doxygen 编辑支持

**Files:**
- Modify: `config/lang/c_cpp.nix`
- Modify: `config/plugins/editing.nix`

**Step 1:** 接入轻量文档注释插件或等价配置。
**Step 2:** 将 C/C++ 默认风格设为 Doxygen 风格注释。
**Step 3:** 验证 Neovim 可正常启动。
**Step 4:** 提交。

# Workflow Migration Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 为 `xxvim` 补齐更接近 LazyVim 的工作流层体验。

**Architecture:** 在现有 nixvim 模块基础上增加 `workflow` Lua 模块，使用原生 terminal + 会话命令 + gitsigns/snacks 接口来完成 terminal、window、git、project 体验增强。

**Tech Stack:** nixvim、Neovim Lua、snacks.nvim、gitsigns.nvim、alpha-nvim。

---

### Task 1: Terminal 与 Window
**Files:**
- Modify: `config/keymaps.nix`
- Create: `config/lua/xxvim/workflow.lua`
- Modify: `config/editor.nix`

**Step 1:** 增加浮动终端与底部终端实现
**Step 2:** 增加窗口/buffer 快捷操作
**Step 3:** 运行验证命令

### Task 2: Git 与 Project
**Files:**
- Modify: `config/keymaps.nix`
- Modify: `config/lua/xxvim/ui.lua`
- Modify: `config/lua/xxvim/workflow.lua`

**Step 1:** 增加 git hunk / blame / diff / picker 入口
**Step 2:** 增加 session 保存恢复与最近项目
**Step 3:** 运行验证命令

### Task 3: 文档与提交
**Files:**
- Modify: `README.md`

**Step 1:** 更新按键与使用说明
**Step 2:** 执行最终验证
**Step 3:** `git add . && git commit -m "feat: 补齐 xxvim 的工作流体验"`

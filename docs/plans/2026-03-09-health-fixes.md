# Health Fixes Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 补齐健康检查里需要常驻的运行时依赖，并清理 `<leader>r` 的重复 which-key 注册。

**Architecture:** 通过各语言/插件 Nix 模块把缺失的外部工具纳入 `extraPackages`，通过 Treesitter grammarPackages 补齐 `bash` 与 `regex`。键位问题通过收敛 which-key 分组注册来源解决，避免全局与 buffer-local 重复声明。

**Tech Stack:** Nix, NixVim, Lua, which-key, snacks, noice, conform, sqlite

---

### Task 1: 补齐运行时依赖

**Files:**
- Modify: `config/lang/rust.nix`
- Modify: `config/core/packages.nix`
- Modify: `config/lang/rust.nix`
- Modify: `config/plugins/lsp.nix`
- Modify: `config/plugins/appearance.nix`

**Step 1: 修改 Nix 配置**
加入 `rustfmt`、`ghostscript`、`texlive`/`pdflatex`、`mermaid-cli`、`sqlite` 以及缺失的 Treesitter parser。

**Step 2: 运行验证**
Run: `nix flake check`
Expected: exit 0

### Task 2: 清理 `<leader>r` 重复注册

**Files:**
- Modify: `config/plugins/appearance.nix`
- Modify: `config/lua/xxvim/tasks.lua`
- Check: `config/meta/keymap-groups.json`

**Step 1: 找出重复来源**
确认是全局 which-key 分组与任务模块 buffer-local 注册重复，还是任务模块内部重复。

**Step 2: 最小化实现**
保留一处权威注册来源，移除多余声明。

**Step 3: 运行验证**
Run: `nix run .#xxvim -- --headless '+checkhealth which-key' '+qa'`
Expected: `<leader>r` 重复项消失或显著减少

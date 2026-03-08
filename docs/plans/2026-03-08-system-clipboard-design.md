# System Clipboard Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 让 `yy`、`dd`、`p`、`P` 等默认复制粘贴操作直接对接系统剪贴板。

**Architecture:** 在全局 NixVim `opts` 中设置 `clipboard = "unnamedplus"`，不新增按键映射，不改动插件逻辑。这样默认寄存器直接绑定系统剪贴板，行为与 LazyVim 本地默认方案保持一致。

**Tech Stack:** Nix, NixVim, Neovim

---

### Task 1: 配置系统剪贴板

**Files:**
- Modify: `config/core/options.nix`
- Verify: `flake.nix`

**Step 1: 修改全局选项**

在 `opts` 中加入：

```nix
clipboard = "unnamedplus";
```

**Step 2: 运行配置校验**

Run: `nix flake check`
Expected: exit 0

**Step 3: 运行无界面启动检查**

Run: `nix run .#xxvim -- --headless '+qa'`
Expected: exit 0

**Step 4: 提交变更**

```bash
git add config/core/options.nix docs/plans/2026-03-08-system-clipboard-design.md
git commit -m "feat: 默认复制粘贴使用系统剪贴板"
```

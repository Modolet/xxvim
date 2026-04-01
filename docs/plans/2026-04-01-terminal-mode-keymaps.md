# 终端模式按键调整 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 让所有 `terminal` buffer 在终端模式下支持 `<C-h/j/k/l>` 切换窗口，并通过双击 `<Esc>` 回到 normal 模式。

**Architecture:** 在 `config/lua/xxvim/terminal.lua` 中抽出通用终端缓冲区按键函数，并通过 `TermOpen` 自动命令对所有终端缓冲区统一绑定。内置终端的专有关闭键位继续在现有逻辑中设置。

**Tech Stack:** NixVim, Lua, Neovim terminal/autocmd API

---

### Task 1: 补充设计文档并规划实现

**Files:**
- Create: `docs/plans/2026-04-01-terminal-mode-keymaps-design.md`
- Create: `docs/plans/2026-04-01-terminal-mode-keymaps.md`

**Step 1: 记录已确认设计**

写明所有终端缓冲区统一键位、`TermOpen` 自动命令挂载点、以及保留现有关闭行为。

**Step 2: 检查文档已保存**

Run: `sed -n '1,200p' docs/plans/2026-04-01-terminal-mode-keymaps-design.md`
Expected: 文档内容完整可读

**Step 3: 提交文档**

```bash
git add docs/plans/2026-04-01-terminal-mode-keymaps-design.md docs/plans/2026-04-01-terminal-mode-keymaps.md
git commit -m "docs: 记录终端模式按键调整设计"
```

### Task 2: 为所有终端缓冲区绑定通用按键

**Files:**
- Modify: `config/lua/xxvim/terminal.lua`

**Step 1: 写出最小行为检查思路**

确认修改后所有 `TermOpen` 打开的缓冲区都能获得：
- `t` 模式下 `<C-h/j/k/l>` 切换窗口
- `t` 模式下 `<Esc><Esc>` 返回 normal

**Step 2: 实现最小代码**

- 增加通用终端缓冲区映射函数
- 在 `setup_commands()` 中创建 `TermOpen` 自动命令
- 让内置终端复用该函数

**Step 3: 自检变更**

Run: `sed -n '1,260p' config/lua/xxvim/terminal.lua`
Expected: 通用映射函数与 `TermOpen` 自动命令存在，且内置终端关闭键位未丢失

### Task 3: 验证并提交功能

**Files:**
- Modify: `config/lua/xxvim/terminal.lua`

**Step 1: 运行仓库验证**

Run: `nix flake check`
Expected: 成功

**Step 2: 运行 headless 启动检查**

Run: `nix run .#xxvim -- --headless '+qa'`
Expected: 成功退出

**Step 3: 提交最终功能**

```bash
git add config/lua/xxvim/terminal.lua docs/plans/2026-04-01-terminal-mode-keymaps-design.md docs/plans/2026-04-01-terminal-mode-keymaps.md
git commit -m "feat: 优化终端模式窗口切换与退出键位"
```

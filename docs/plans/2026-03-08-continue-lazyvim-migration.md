# Continue LazyVim Migration Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 继续把 `xxvim` 的体验补齐到更接近 LazyVim 默认使用感。

**Architecture:** 保持现有 `nixvim` 模块结构，通过增补 UI/导航/LSP/DAP 插件与 Lua 行为配置推进。优先声明式配置，必要时用局部 Lua 完成 `snacks`、`dap`、`which-key` 等行为细节。

**Tech Stack:** Nix flakes、nixvim、Neovim Lua、snacks.nvim、blink.cmp、nvim-lspconfig、nvim-dap。

---

### Task 1: 补基础体验
**Files:**
- Modify: `config/default.nix`
- Modify: `config/ui.nix`
- Modify: `config/theme.nix`
- Modify: `config/lua/xxvim/ui.lua`
- Modify: `README.md`

**Step 1:** 增加 dashboard、gitsigns、indent guides 等插件与配置
**Step 2:** 细化 lualine / bufferline / which-key / noice 的展示
**Step 3:** 运行 `nix flake check`
**Step 4:** 运行 `nix run .#xxvim -- --headless '+qa'`

### Task 2: 增强导航与搜索
**Files:**
- Modify: `config/ui.nix`
- Modify: `config/keymaps.nix`
- Modify: `config/lua/xxvim/ui.lua`

**Step 1:** 扩充 snacks picker / explorer 行为
**Step 2:** 补全 `<leader>` 搜索与导航键位
**Step 3:** 运行验证命令

### Task 3: 细化 LSP
**Files:**
- Modify: `config/languages.nix`
- Modify: `config/keymaps.nix`
- Modify: `config/lua/xxvim/lsp.lua`

**Step 1:** 统一 LSP 交互与 diagnostics/navigation 键位
**Step 2:** 优化 hover、workspace symbols、format 等行为
**Step 3:** 运行验证命令

### Task 4: 细化 DAP
**Files:**
- Modify: `config/dap.nix`
- Modify: `config/keymaps.nix`
- Modify: `config/lua/xxvim/dap.lua`
- Modify: `README.md`

**Step 1:** 增加更完整的调试键位与断点能力
**Step 2:** 优化 dap-ui 生命周期和适配器入口
**Step 3:** 运行验证命令

### Task 5: 收尾与提交
**Files:**
- Modify: `README.md`

**Step 1:** 更新文档
**Step 2:** 执行最终验证
**Step 3:** `git add . && git commit -m "feat: 继续完善 xxvim 的 lazyvim 体验"`

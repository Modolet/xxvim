# JSON Language Support Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 为 xxvim 增加独立的 JSON 语言模块，接入 `jsonls` 提供完整 JSON 编辑能力。

**Architecture:** 新增 `config/lang/json.nix`，集中声明 JSON 的 LSP 与 Tree-sitter 配置，并在 `config/lang/default.nix` 中导入。保留现有 `prettier` 格式化链路，不再重新引入外部 JSON linter。

**Tech Stack:** Nix flakes、nixvim、Neovim LSP、`vscode-langservers-extracted`、Tree-sitter。

---

### Task 1: 先写失败验证

**Files:**
- Inspect: `config/lang/default.nix`
- Inspect: `config/plugins/lsp.nix`

**Step 1: 运行当前 JSON LSP 探针**

Run: `nix run .#xxvim -- --headless "+e /tmp/xxvim-plan-probe.json" "+lua print(vim.inspect(vim.lsp.get_clients({ name = 'jsonls' })))" '+qa'`

Expected: 输出为空列表或没有 `jsonls` client，证明当前尚未接入。

**Step 2: 记录失败现象**

Expected: JSON 当前没有独立 LSP 能力，只有格式化链路。

### Task 2: 新增 JSON 模块

**Files:**
- Create: `config/lang/json.nix`

**Step 1: 写入最小实现**

内容包括：
- `plugins.treesitter.grammarPackages` 增加 `json` 与 `jsonc`
- `plugins.lsp.servers.jsonls.enable = true`

**Step 2: 保持实现最小**

不新增 schema 自定义配置，不改动其他语言模块。

### Task 3: 接入模块导入

**Files:**
- Modify: `config/lang/default.nix`

**Step 1: 导入 `./json.nix`**

将 JSON 模块加入现有语言模块列表。

**Step 2: 检查导入位置**

保持文件风格与现有模块列表一致。

### Task 4: 验证实现

**Files:**
- Verify: `config/lang/json.nix`
- Verify: `config/lang/default.nix`

**Step 1: 运行仓库标准检查**

Run: `nix flake check`
Expected: 通过。

**Step 2: 运行 headless 启动检查**

Run: `nix run .#xxvim -- --headless '+qa'`
Expected: 通过。

**Step 3: 运行 JSON 定向检查**

Run: `tmp=$(mktemp --suffix=.json) && printf '{"ok":true}\n' > "$tmp" && nix run .#xxvim -- --headless "+e $tmp" '+lua local clients = vim.lsp.get_clients({ name = "jsonls" }); print("jsonls_clients=" .. #clients)' '+sleep 100m' '+qa' && rm -f "$tmp"`
Expected: 输出 `jsonls_clients=1` 或更大。

### Task 5: 提交变更

**Files:**
- Commit: `config/lang/json.nix`
- Commit: `config/lang/default.nix`
- Commit: `docs/plans/2026-03-08-json-language-support-design.md`
- Commit: `docs/plans/2026-03-08-json-language-support.md`

**Step 1: 查看变更**

Run: `git status --short`

**Step 2: 提交**

Run: `git commit -m "feat: 增加 json 语言支持"`

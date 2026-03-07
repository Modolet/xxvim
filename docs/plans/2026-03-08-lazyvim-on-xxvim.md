# LazyVim 风格 xxvim Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 用 `nixvim + flake` 构建一个尽量贴近 LazyVim 默认体验的 `xxvim`，并把编辑器所需开发工具一并打包，同时提供可选 `devShell`。

**Architecture:** 采用 `flake.nix` 作为单一入口，输出 `packages` 中的 `xxvim` 可执行与轻量 `devShell`。NixVim 配置按功能拆分为主题/UI、编辑增强、补全、LSP、DAP、语言与按键模块；语言服务器、格式化器、调试器通过 `extraPackages` 等方式打进编辑器运行时而非依赖 Mason 在线下载。

**Tech Stack:** Nix flakes、nixvim、nixpkgs、Neovim Lua 配置、Treesitter/LSP/DAP 生态插件。

---

### Task 1: 搭建 flake 与模块骨架

**Files:**
- Create: `flake.nix`
- Create: `config/default.nix`
- Create: `config/core.nix`
- Create: `config/theme.nix`
- Create: `config/ui.nix`
- Create: `config/keymaps.nix`
- Create: `README.md`

**Step 1: 写基础 flake 与 nixvim 引入**

创建 `flake.nix`，引入 `nixpkgs`、`nixvim`，导出 `packages` 和 `devShells`。

**Step 2: 写最小 nixvim 模块集合**

在 `config/default.nix` 中聚合核心模块，在 `core/theme/ui/keymaps` 中写最小可启动配置。

**Step 3: 运行构建验证骨架可求值**

Run: `nix flake check`
Expected: flake 成功求值，无语法错误。

### Task 2: 复刻 LazyVim 风格基础体验

**Files:**
- Modify: `config/core.nix`
- Modify: `config/theme.nix`
- Modify: `config/ui.nix`
- Modify: `config/keymaps.nix`
- Create: `config/editor.nix`

**Step 1: 接入主题与界面插件**

配置 `catppuccin`、状态栏、bufferline、which-key/noice 等 LazyVim 风格基础能力。

**Step 2: 写编辑增强能力**

配置 `yanky.nvim`、`dial.nvim`、`inc-rename.nvim`、必要的 Lua 辅助设置。

**Step 3: 运行构建验证插件配置有效**

Run: `nix flake check`
Expected: 配置仍然可求值。

### Task 3: 接入 picker / explorer / completion

**Files:**
- Create: `config/coding.nix`
- Modify: `config/ui.nix`
- Modify: `config/keymaps.nix`

**Step 1: 配置 `blink.cmp` 与 snippets**

启用 `blink.cmp`、`friendly-snippets`、`blink.compat`，设置接近 LazyVim 的补全行为。

**Step 2: 配置 `snacks.nvim` picker / explorer**

启用文件浏览、查找、grep、recent 等常用能力，并绑定常用按键。

**Step 3: 运行构建验证相关插件**

Run: `nix flake check`
Expected: 通过。

### Task 4: 接入语言与工具链

**Files:**
- Create: `config/languages.nix`
- Modify: `config/default.nix`
- Modify: `flake.nix`
- Modify: `README.md`

**Step 1: 声明编辑器内工具包**

将 Rust/C/C++/JSON/CMake/Python/Markdown/Nix/TOML 所需 LSP、formatter、lint 工具加入 `extraPackages`。

**Step 2: 配置 treesitter 与 LSP**

为上述语言配置 Treesitter、LSP、格式化与保存时格式化策略。

**Step 3: 运行构建验证语言配置**

Run: `nix flake check`
Expected: 通过。

### Task 5: 接入 DAP 与调试体验

**Files:**
- Create: `config/dap.nix`
- Modify: `config/default.nix`
- Modify: `flake.nix`
- Modify: `README.md`

**Step 1: 配置 `nvim-dap` 生态**

启用 `nvim-dap`、`nvim-dap-ui`、`nvim-dap-virtual-text`、`nvim-nio` 及必要按键。

**Step 2: 配置语言调试器**

为 Rust/C/C++/Python 连接 `codelldb` 或 `gdb/lldb`、`debugpy` 等调试器。

**Step 3: 运行构建验证 DAP 配置**

Run: `nix flake check`
Expected: 通过。

### Task 6: 完成文档与最终验证

**Files:**
- Modify: `README.md`

**Step 1: 补充使用说明**

说明如何运行 `xxvim`、如何进入 `devShell`、包含哪些语言工具与插件能力。

**Step 2: 运行最终验证**

Run: `nix flake check`
Expected: 通过。

**Step 3: 若存在 git 仓库则提交**

```bash
git add .
git commit -m "feat: 使用 nixvim 和 flake 初始化 xxvim"
```

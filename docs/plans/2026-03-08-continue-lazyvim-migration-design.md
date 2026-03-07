# 继续移植 LazyVim 风格到 xxvim 设计说明

## 目标

在现有 `nixvim + flake` 版本 `xxvim` 基础上，继续向 LazyVim 默认体验靠拢，按以下顺序推进：基础体验、导航与搜索、LSP 体验、DAP 体验。

## 方案选择

采用方案 A：**基础体验 → 导航与搜索 → LSP 体验 → DAP 体验**。

原因：
- 先统一 UI、消息、状态与按键分组，后续能力更容易挂接
- `snacks` 与 LSP/DAP 的入口都依赖一致的 `<leader>` 分组与窗口组织
- 更利于阶段性验证，避免配置互相覆盖

## 架构原则

- 继续使用现有模块拆分：`ui.nix`、`editor.nix`、`coding.nix`、`languages.nix`、`dap.nix`、`keymaps.nix`
- 优先使用 `nixvim` 原生模块；缺失处用 `extraPlugins + Lua`
- 工具链仍然内置到编辑器环境，并同时暴露到 `devShell`
- 行为配置集中在 `config/lua/xxvim/*.lua`

## 本轮要补的内容

### 1. 基础体验
- 增加 dashboard
- 增加 `gitsigns` 和缩进指示
- 细化 `lualine`、`bufferline`、`which-key`
- 优化 `noice` / `notify` / `snacks` 的消息与 UI 行为

### 2. 导航与搜索
- 扩充 `snacks` picker 的 files / grep / buffers / recent / diagnostics / symbols / git files
- 增加更完整的 `<leader>` 分组与描述
- 让 explorer 更接近 LazyVim 的文件导航习惯

### 3. LSP 体验
- 补充 hover / diagnostics / references / implementations / document symbols / workspace symbols
- 统一 code action、rename、format、trouble-like diagnostics 入口
- 优化 attach 时按键和提示

### 4. DAP 体验
- 补充 step over / into / out / terminate / repl / run last
- 补充条件断点与日志断点
- 优化 UI 自动打开与关闭时机
- 保持 Rust/C/C++/Python 的默认调试入口可用

## 验证策略

每个阶段结束后至少执行：
- `nix flake check`
- `nix run .#xxvim -- --headless '+qa'`

最终完成后提交中文 Conventional Commit。

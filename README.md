# xxvim

一个使用 `nixvim + flake` 实现、尽量贴近 LazyVim 默认体验的 Neovim 发行版。

## 特性

- 使用 `catppuccin` 主题、dashboard、状态栏、标签栏、git signs、缩进指示
- 集成 `blink.cmp`、`friendly-snippets`、`blink.compat`
- 集成 `yanky.nvim`、`dial.nvim`、`inc-rename.nvim`
- 集成 `snacks.nvim` 的 picker / explorer / diagnostics / symbols / recent / git 能力
- 集成 `trouble.nvim` 用于诊断与问题列表
- 集成 `nvim-dap`、`nvim-dap-ui`、`nvim-dap-virtual-text`
- 内置 Rust / C / C++ / JSON / CMake / Python / Markdown / Nix / TOML 开发工具

## 运行

```bash
nix run .#xxvim
```

## 开发环境

```bash
nix develop
```

`nix develop` 会提供与编辑器内基本一致的工具集；但主要交付仍是 `xxvim` 可执行本身，语言服务器、格式化器和调试器也会被打包到编辑器运行环境里。

## 默认按键

### 文件与搜索

- `<leader>e`：打开 explorer
- `<leader><space>`：智能查找文件
- `<leader>ff`：查找文件
- `<leader>fg`：全文搜索
- `<leader>fb`：搜索缓冲区
- `<leader>fr`：最近文件
- `<leader>sd`：工作区诊断
- `<leader>sD`：当前缓冲区诊断
- `<leader>ss`：文档符号
- `<leader>sS`：工作区符号

### LSP

- `gd` / `gD` / `gr` / `gI` / `gt`：定义、声明、引用、实现、类型定义
- `K`：悬浮文档
- `<leader>ca`：代码动作
- `<leader>rn`：增量重命名
- `<leader>cf`：格式化
- `[d` / `]d`：前后跳转诊断
- `<leader>xx`：Trouble 诊断列表

### DAP

- `<leader>db`：切换断点
- `<leader>dB`：条件断点
- `<leader>dl`：日志断点
- `<leader>dc`：继续运行
- `<leader>dr`：再次运行
- `<leader>do` / `<leader>di` / `<leader>dO`：步过 / 步入 / 步出
- `<leader>du`：切换 DAP UI
- `<leader>dR`：REPL
- `<leader>dt`：终止调试

# xxvim

一个使用 `nixvim + flake` 实现、尽量贴近 LazyVim 默认体验的 Neovim 发行版。

## 特性

- 默认使用 `catppuccin` 主题，并兼容由 `Stylix` 接管配色的场景
- 集成 `blink.cmp`、`friendly-snippets`、`blink.compat`、`copilot.lua`
- 集成 `yanky.nvim`、`dial.nvim`、`inc-rename.nvim`、`nvim-autopairs`、`mini.surround`、`mini.ai`
- 集成 `snacks.nvim` 的 picker / explorer / diagnostics / symbols / recent / git 能力
- 集成 `trouble.nvim` 用于诊断与问题列表
- 集成 `nvim-dap`、`nvim-dap-ui`、`nvim-dap-virtual-text`
- 集成 `nvim-lint`、`overseer.nvim`、`neotest`、`persistence.nvim`
- 提供浮动终端、底部终端、session 保存恢复、最近项目切换、LazyGit
- 内置 Rust / C / C++ / JSON / CMake / Python / Markdown / Nix / TOML 开发工具

## 运行

```bash
nix run .#xxvim
```

这条路径适合调试和快速试用；`packages.${system}.xxvim` 仍然是本仓库的可执行发行版入口。

## 作为 Home Manager 模块使用

日常使用更推荐通过 flake 输出的 `homeModules.default` 接入，这样上层配置可以继续组合、覆盖和管理整套编辑器行为。

```nix
{
  inputs.xxvim.url = "github:yourname/xxvim";

  outputs = { nixpkgs, home-manager, xxvim, ... }: {
    homeConfigurations.me = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      modules = [
        xxvim.homeModules.default
      ];
    };
  };
}
```

如果你在上层 Home Manager / NixOS 配置里已经启用了 `Stylix`，建议同时打开：

```nix
{
  xxvim.theme.stylix.enable = true;
}
```

这样 `xxvim` 会停用内置 `catppuccin` 配色接管，并避免给 `lualine` 强制指定 `catppuccin` 主题，让 `Stylix` 统一管理界面颜色。

`homeModules.default` 已经自带 `nixvim` 的 Home Manager 包装层，上层只需要导入这一个模块即可。

## 输出设计

- `config/`：唯一配置真源
- `homeModules.default`：日常 Home Manager 复用入口
- `packages.${system}.xxvim`：预组装的调试/启动入口
- `packages.${system}.default`：`xxvim` 的默认包别名

## 开发环境

```bash
nix develop
```

`nix develop` 会提供与编辑器内基本一致的工具集；但主要交付仍是 `xxvim` 可执行本身，语言服务器、格式化器、测试工具和调试器也会被打包到编辑器运行环境里。

## 默认按键

按键分组标签与 which-key 分组来源已统一到 `config/meta/keymap-groups.json:1`，后续调整 `<leader>` 顶层分组时应优先修改该文件。

### 文件与搜索
- `<leader>e`：打开 explorer
- `<leader><space>`：智能查找文件
- `<leader>ff`：查找文件
- `<leader>fg`：全文搜索
- `<leader>fb`：搜索缓冲区
- `<leader>fr`：最近文件
- `<leader>fp`：最近项目
- `<leader>sr`：Search and Replace（普通模式预填当前词；可视模式预填选区；范围默认为项目根目录）
- `<leader>sR`：恢复上一次 picker
- `<leader>sd`：工作区诊断
- `<leader>sD`：当前缓冲区诊断
- `<leader>ss`：文档符号
- `<leader>sS`：工作区符号

### Git
- `<leader>gc` / `<leader>gC`：git log / 当前行 log
- `<leader>gs`：git status
- `<leader>gg`：LazyGit
- `<leader>gB`：当前行 blame
- `<leader>gd`：diff 当前文件
- `]h` / `[h`：跳到下一个 / 上一个 hunk
- `<leader>ghs` / `<leader>ghr`：stage / reset hunk
- `<leader>ghp`：预览 hunk

### LSP / Diagnostics
- `gd` / `gD` / `gr` / `gI` / `gt`：定义、声明、引用、实现、类型定义
- `K`：悬浮文档
- `<leader>ca`：代码动作
- `<leader>cr`：LSP 重命名
- `<leader>cf`：格式化
- `[d` / `]d`：前后跳转诊断
- `<leader>xx`：Trouble 诊断列表

### Completion
- `<C-j>` / `<C-k>`：向下 / 向上选择补全候选
- `<CR>`：接受当前补全候选
- `<Tab>` / `<S-Tab>`：在 snippet 占位符间前进 / 后退
- `<M-l>`：接受 Copilot 幽灵文本补全

### Tests / Tasks
- `<leader>tn`：运行最近测试
- `<leader>tf`：运行当前文件测试
- `<leader>td`：使用 DAP 调试最近测试
- `<leader>to`：打开测试输出
- `<leader>tS`：切换测试摘要
- `<leader>tr`：运行 Overseer 任务
- `<leader>tt`：切换任务列表

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

### Terminal / Window / Session
- `<leader>T` / `<leader>tb`：浮动终端 / 底部终端
- `<leader>ws` / `<leader>wv`：水平 / 垂直分屏
- `<leader>wd` / `<leader>wo` / `<leader>w=`：关闭窗口 / 仅保留当前 / 均分窗口
- `<S-h>` / `<S-l>`：上一个 / 下一个 buffer
- `<leader>bd` / `<leader>bo`：删除当前 / 其他 buffer
- `<leader>qs` / `<leader>ql`：恢复 session / 恢复最后 session
- `<leader>qS` / `<leader>qd`：选择 session / 停止保存当前 session

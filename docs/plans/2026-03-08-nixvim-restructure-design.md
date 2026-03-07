# xxvim 配置重构设计

**日期：** 2026-03-08
**目标：** 以可维护性优先，对 `xxvim` 进行结构化重构，明确 `Nix` 与 `Lua` 分工，降低模块耦合和文档漂移风险。

---

## 背景

当前配置已经具备较完整的 LazyVim 风格体验，但随着功能逐步累积，出现了几个明显问题：

- `config/default.nix` 同时承担入口、插件聚合和工具链聚合职责，边界过重。
- `config/keymaps.nix` 体量过大，已经接近“所有行为入口表”，难以 review 和局部维护。
- `config/lua/xxvim/tools.lua` 与 `config/lua/xxvim/workflow.lua` 承担了多类运行时逻辑，职责不清。
- 插件声明、运行时逻辑、映射定义和 README 文档之间缺少清晰的单一事实源，已出现漂移。

本轮重构不追求新增功能，重点是建立后续可持续演进的配置骨架。

## 目标

### 主要目标

- 降低配置文件的认知负担与耦合度。
- 将“插件静态配置”“语言工具链配置”“运行时行为”“按键声明”分层管理。
- 明确哪些逻辑应由 `nixvim` 原生选项表达，哪些逻辑保留在 Lua。
- 为后续继续拆分 keymap 元数据和文档同步打基础。

### 非目标

- 不在本轮追求完全自动生成 README 或 which-key 元数据。
- 不在本轮引入新的插件体系或大规模行为调整。
- 不追求一次性重构所有语言生态，只先把现有结构整理到合理边界。

## 设计原则

### 1. 采用“三层结构”

将配置改为以下主结构：

- `config/core/`
  - 全局基础设施：选项、主题、全局变量、基础包。
- `config/plugins/`
  - 插件级静态配置：一插件一文件或一组强关联插件一文件。
- `config/lang/`
  - 语言专属工具链与配置：LSP、formatter、linter、语言依赖。

同时补充：

- `config/keymaps/`
  - 只放映射声明，按主题拆分。
- `config/lua/xxvim/`
  - 只保留运行时逻辑，按职责拆分模块。

### 2. 优先 Nix，必要时才用 Lua

- 静态、声明式、可枚举的配置优先使用 Nix。
- 动态、运行时、状态驱动、依赖当前 buffer/window/tab 的逻辑放入 Lua。
- 能用 `nixvim` 模块表达的配置，不额外用 Lua 替代。
- 复杂 Lua 逻辑必须落文件，不继续以内联 `extraConfigLua` 大块堆积。

### 3. keymap 只做路由，不做实现

- `config/keymaps/*.nix` 仅负责声明键位、描述和调用入口。
- 复杂逻辑统一收敛到 `config/lua/xxvim/*` 模块。
- 避免 keymap 文件中嵌入长 Lua 字符串或业务实现。

## 目标结构

```text
config/
  default.nix
  core/
    default.nix
    options.nix
    theme.nix
    packages.nix
  plugins/
    default.nix
    alpha.nix
    blink.nix
    bufferline.nix
    dap.nix
    gitsigns.nix
    lsp.nix
    lualine.nix
    noice.nix
    snacks.nix
    trouble.nix
    which-key.nix
  lang/
    default.nix
    c_cpp.nix
    nix.nix
    python.nix
    rust.nix
    docs.nix
  keymaps/
    default.nix
    core.nix
    search.nix
    git.nix
    lsp.nix
    debug.nix
    test.nix
    ui.nix
    window_buffer.nix
    session_terminal.nix
config/lua/xxvim/
  buffers.lua
  dashboard.lua
  dap.lua
  git.lua
  root.lua
  session.lua
  terminal.lua
  toggle.lua
```

## Nix / Lua 分工规则

### 适合放 Nix 的内容

- 插件 enable/disable。
- 插件的静态 settings。
- Treesitter、LSP、formatter、linter 的静态注册。
- `extraPackages` 中的外部工具链与依赖。
- 简单 keymap 声明。

### 适合放 Lua 的内容

- root 检测。
- toggle 状态管理。
- terminal/session/buffer/window 编排。
- DAP 动态输入行为。
- runtime 条件判断较多的 autocmd / picker 逻辑。
- `nixvim` 现阶段原生选项难以优雅表达的插件补充配置。

## 迁移策略

### 第一阶段：建立目录骨架并迁移静态配置

- 将现有 `core.nix`、`theme.nix`、`ui.nix`、`coding.nix`、`languages.nix`、`dap.nix`、`tools.nix` 逐步拆解到 `core/`、`plugins/`、`lang/`。
- 将 `default.nix` 收敛为纯 `imports` 入口。
- 将 `extraPlugins` 和 `extraPackages` 从总入口下沉到更贴近职责的模块。

### 第二阶段：拆解运行时 Lua

- 将 `tools.lua` 拆为 `root.lua`、`toggle.lua`、`testing.lua`/`tasks.lua`。
- 将 `workflow.lua` 拆为 `terminal.lua`、`session.lua`、`buffers.lua`、`git.lua`。
- 减少 `_G.xxvim_*` 暴露，改为 `require("xxvim.<module>")` 调用。

### 第三阶段：拆分 keymaps

- 将 `config/keymaps.nix` 拆到 `config/keymaps/` 下按主题归档。
- 保持原有按键行为稳定，不在本轮进行大规模按键调整。
- 为后续统一 which-key / README 元数据留出组织空间。

## 风险与取舍

- 重构过程中存在导入路径、Lua require 路径和命令入口断裂风险，需要依赖 `nix flake check` 与 headless 启动验证。
- 本轮优先稳定迁移，不对用户可见行为做激进变更。
- `_G` 的收缩会影响旧 keymap 调用方式，因此需要先建立兼容层或同步迁移映射入口。

## 验证方式

最小验证要求：

- `nix flake check`
- `nix run .#xxvim -- --headless '+qa'`

如果本轮涉及 UI/快捷键/插件 wiring 的明显调整，再额外执行：

- `nix run .#xxvim`

## 预期成果

完成本轮后，仓库应具备以下特征：

- 入口文件极薄。
- 插件配置、语言配置、运行时逻辑、按键声明边界明确。
- 新增/删除功能时可以快速定位修改位置。
- 后续继续重构文档、which-key 和 keymap 元数据时不需要再重新拆骨架。

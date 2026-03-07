# xxvim 工作流层 LazyVim 迁移设计

## 目标

继续把 `xxvim` 向 LazyVim 的日常工作流体验靠拢，补齐终端、git、窗口管理、buffer 管理、session/project 切换等能力。

## 选型

采用工作流优先方案：**terminal → window/buffer → git → session/project**。

原因：
- 这些能力直接影响每天使用频率，收益最高
- 与现有 `snacks` / `gitsigns` / `alpha` / `which-key` 已有配置能自然衔接
- 便于通过统一 `<leader>` 分组构建完整心智模型

## 范围

### 1. Terminal
- 增加浮动终端与底部终端入口
- 增加快速切换、发送 cwd 的行为
- 保持依赖最少，优先用 Neovim 原生 terminal + Lua 封装

### 2. Window / Buffer
- 增加窗口拆分、关闭、仅保留当前窗口、均分窗口
- 增加 buffer 上一个/下一个/删除其他 buffer
- 补充与 bufferline 一致的操作习惯

### 3. Git
- 增加 hunk 跳转、stage/reset hunk、blame、diff、打开文件历史/状态
- 继续使用 `gitsigns` 与 `snacks` picker

### 4. Session / Project
- 启动页增加最近项目入口
- 提供保存/恢复 session 的轻量实现
- 最近项目基于 cwd 历史或 `oldfiles` / 项目根推断实现

## 实现原则
- 优先复用已有插件，减少额外依赖
- 缺失能力用 `config/lua/xxvim/workflow.lua` 集中实现
- `keymaps.nix` 只保留入口，行为细节放 Lua
- 每阶段后执行 `nix flake check` 和无头启动验证

# LazyVim 风格确认弹窗、搜索替换与 Stylix 兼容 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 为 xxvim 增加 LazyVim 风格的未保存确认弹窗、将 `<leader>sr` 改为 Search and Replace，并让主题在启用 Stylix 时保持兼容。

**Architecture:** 保持现有 NixVim 模块结构，通过小范围扩展 `config/keymaps/*`、`config/plugins/*` 与 `config/lua/xxvim/*` 完成。未保存确认优先使用 Neovim 的 confirm 机制并补齐自定义关闭其它 buffer 的调用链；搜索替换采用 LazyVim 常见的 `grug-far.nvim` 工作流；Stylix 兼容通过提供可切换的主题来源，避免与 Catppuccin 强绑定。

**Tech Stack:** Nix flakes, NixVim, Neovim Lua, snacks.nvim, bufferline, noice, grug-far.nvim, Stylix.

---

### Task 1: 审阅现有 buffer/quit/search/theme 入口
- Modify: `config/lua/xxvim/buffers.lua`
- Modify: `config/keymaps/window_buffer_tab.nix`
- Modify: `config/keymaps/lsp.nix`
- Modify: `config/core/theme.nix`
- Modify: `config/plugins/appearance.nix`
- Check: 确认当前 `<leader>bo`、`q/qa`、`<leader>sr`、主题配置的实现位置。

### Task 2: 设计 LazyVim 风格确认弹窗接入点
- Modify: `config/lua/xxvim/buffers.lua`
- Modify: `config/keymaps/window_buffer_tab.nix`
- Check: 明确哪些操作需要 `confirm`：关闭其他 buffer、`q` 退出未保存窗口、必要时 `qa`/dashboard quit。
- Check: 选定实现策略：优先 `confirm` + 非强制删除，避免无提示丢失修改。

### Task 3: 先写最小实现让关闭其它 buffer 走确认路径
- Modify: `config/lua/xxvim/buffers.lua`
- Modify: `config/keymaps/window_buffer_tab.nix`
- Step: 添加可复用的 buffer 删除/关闭其它 buffer Lua helper。
- Step: 将 `<leader>bo` 改为调用 helper，并在遇到修改 buffer 时弹出确认。
- Step: 为 `q`/相关 quit 命令添加 confirm 入口。

### Task 4: 接入 Search and Replace 工作流
- Modify: `config/plugins/editing.nix`
- Modify: `config/keymaps/lsp.nix`
- Modify: `README.md`
- Step: 添加 `grug-far.nvim`（或等价 LazyVim 风格插件）配置。
- Step: 将 `<leader>sr` 改为 Search and Replace，支持当前词/可视选区/项目根目录工作流。
- Step: 更新 README 快捷键说明。

### Task 5: 做 Stylix 兼容
- Modify: `config/core/theme.nix`
- Modify: `config/plugins/appearance.nix`
- Modify: `config/default.nix`
- Modify: `README.md`
- Step: 引入 `stylix` 兼容开关或检测逻辑，避免强制启用 Catppuccin。
- Step: 处理 lualine/bufferline/noice 等主题依赖，确保在 Stylix 场景下仍可启动。
- Step: 更新文档说明启用方式与兼容边界。

### Task 6: 并行实现并集成
- Modify: 上述相关文件
- Step: 使用多 agent 并行处理「确认弹窗」「搜索替换」「Stylix 兼容」。
- Step: 主线程审查 diff 并解决交叉修改。

### Task 7: 运行验证命令
- Run: `nix flake check`
- Run: `nix run .#xxvim -- --headless '+qa'`
- Check: 若涉及未保存确认行为，补充 headless/命令级 smoke check，至少确认配置可加载。

### Task 8: 更新说明并提交
- Modify: `README.md`
- Step: 记录新的快捷键与 Stylix 兼容说明。
- Step: 使用中文 Conventional Commits 提交一次功能点。

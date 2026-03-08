# JSON 语言支持设计

**目标：** 为 xxvim 提供完整的 JSON 编辑能力，包括 LSP 诊断、补全、schema 支持与现有格式化流程的协同。

**背景：** 当前配置中 JSON 仅配置了 `prettier` 格式化，曾额外依赖 `nvim-lint` 的 `jsonlint`，但该工具已从 Nixpkgs 移除，导致编辑 JSON 时触发 `ENOENT`。仓库的语言能力目前按独立模块划分，适合将 JSON 作为单独语言模块接入。

## 方案对比

### 方案 A：仅在现有模块里启用 `jsonls`
- 优点：改动最小。
- 缺点：JSON 相关配置散落，后续扩展 JSONC / schema / 专项工具时不够清晰。

### 方案 B：新增独立 `config/lang/json.nix`
- 优点：与现有 `config/lang/c_cpp.nix`、`config/lang/python.nix` 结构一致；JSON 的 LSP、Tree-sitter 与工具声明集中管理；后续扩展更自然。
- 缺点：新增一个模块文件，改动点略多。

### 方案 C：并入 `config/lang/docs.nix`
- 优点：文件数最少。
- 缺点：JSON 与 Markdown/TOML 的边界不够清楚，长期可维护性较差。

## 选型

采用 **方案 B**：新增独立 `config/lang/json.nix`。

## 架构设计

- 在 `config/lang/json.nix` 中集中声明 JSON 所需能力：
  - `plugins.lsp.servers.jsonls.enable = true`
  - JSON / JSONC 对应的 Tree-sitter grammar
- 在 `config/lang/default.nix` 中导入该模块。
- 保持 `config/plugins/lsp.nix` 中的 `prettier` JSON 格式化配置不变。
- 不再为 JSON 配置外部 linter，诊断统一交给 `jsonls`。

## 数据流与行为

1. 打开 `*.json` 文件。
2. Neovim 根据 filetype 启动 `jsonls`。
3. `jsonls` 提供语法/结构诊断、补全与 schema 相关能力。
4. 保存时仍由现有 `conform-nvim` 调用 `prettier` 进行格式化。

## 错误处理

- 避免依赖已从 Nixpkgs 移除的 `jsonlint`。
- 依赖现有 `nodePackages.vscode-langservers-extracted` 提供 `jsonls` 运行时，减少重复安装。
- 若后续需要更精细的 schema 行为，可在 `jsonls` settings 层扩展，而不影响当前模块边界。

## 验证策略

- `nix flake check`
- `nix run .#xxvim -- --headless '+qa'`
- 定向检查 JSON LSP：打开临时 `.json` 文件并确认存在名为 `jsonls` 的 LSP client。

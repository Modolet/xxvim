# xxvim Home Modules 与 Packages 双输出 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 为 `xxvim` 同时提供适合日常 Home Manager 集成的 `homeModules` 输出，以及适合调试与快速启动的 `packages` 输出，并保证两者共享同一份配置真源。

**Architecture:** 将 `config/` 继续作为唯一真源模块；`packages.${system}.xxvim` 通过 `nixvim.legacyPackages.${system}.makeNixvimWithModule` 基于该模块构建；新增 `homeModules.default`（必要时兼容导出 `homeManagerModules.default`）供上层 flake 直接 `imports`。避免让模块层退化成单纯安装包的包装器，优先让模块直接参与 Home Manager 组合。

**Tech Stack:** Nix flakes、nixpkgs、nixvim、Home Manager 模块语义。

---

### Task 1: 明确模块复用边界

**Files:**
- Modify: `flake.nix`
- Inspect: `config/default.nix`
- Inspect: `config/core/default.nix`

**Step 1: 确认 `config/` 仍作为唯一真源**
- 保持 `config/default.nix` 作为统一模块入口，不复制第二份 Home Manager 专用配置。
- 预期结果：后续 `packages` 与 `homeModules` 都复用这一个入口。

**Step 2: 明确导出命名**
- 采用 `homeModules.default` 作为首选导出名。
- 如兼容性需要，再同时导出 `homeManagerModules.default = self.homeModules.default`。
- 预期结果：既符合你的表达习惯，也兼容常见 flake 消费方式。

**Step 3: 记录验证命令**
Run: `nix flake check`
Expected: flake 仍能成功求值，尚未修改前作为基线确认。

**Step 4: Commit**
```bash
git add flake.nix docs/plans/2026-03-08-home-modules-and-packages.md
git commit -m "docs: 规划 homeModules 与 packages 双输出"
```

### Task 2: 在 `flake.nix` 增加模块输出

**Files:**
- Modify: `flake.nix`

**Step 1: 先写出最小导出结构**
- 在 `outputs` 中新增：
  - `homeModules.default = import ./config;`
- 如果决定兼容别名，再新增：
  - `homeManagerModules.default = self.homeModules.default;`
- 保持 `packages`、`devShells`、`checks` 原有结构不变。

**Step 2: 检查是否引入自引用复杂度**
- 优先避免不必要的 `rec`/`let` 交织。
- 若使用 `self.homeModules.default` 作为别名，确认不会影响 flake 求值可读性。
- 预期结果：`flake.nix` 输出层清晰，`packages` 与 `homeModules` 各司其职。

**Step 3: 运行最小验证**
Run: `nix flake check`
Expected: 通过，说明新增输出未破坏 checks 与包构建。

**Step 4: Commit**
```bash
git add flake.nix
git commit -m "feat: 导出 xxvim 的 homeModules"
```

### Task 3: 确认 `packages` 继续服务调试场景

**Files:**
- Modify: `flake.nix`
- Inspect: `config/default.nix`

**Step 1: 保持 `packages.${system}.xxvim` 的构建路径不变**
- 继续通过 `makeNixvimWithModule` + `module = import ./config;` 构建。
- 不把 `packages` 改造成从 Home Manager 安装路径反推，避免职责混淆。

**Step 2: 检查 `default` 包别名**
- 保持 `packages.${system}.default = xxvim;`。
- 预期结果：`nix run .#xxvim` 与 `nix run .` 的调试体验不变。

**Step 3: 运行无头烟测**
Run: `nix run .#xxvim -- --headless '+qa'`
Expected: 正常退出，无启动报错。

**Step 4: Commit**
```bash
git add flake.nix
git commit -m "fix: 保持 xxvim 包输出用于调试"
```

### Task 4: 为 Home Manager 使用方式补一层可读文档

**Files:**
- Modify: `README.md`
- Modify: `flake.nix` (如需在描述中补充)

**Step 1: 增加两种使用方式说明**
- 在 README 中分别说明：
  - 调试/试用：`nix run .#xxvim`
  - 日常集成：在上层 flake 中 `imports = [ inputs.xxvim.homeModules.default ]`
- 给出最小 Home Manager 片段示例。

**Step 2: 说明推荐心智模型**
- 明确写出：
  - `config/` 是配置真源
  - `homeModules` 是复用接口
  - `packages` 是预组装发行版/调试入口
- 预期结果：后续维护时不容易把职责搞混。

**Step 3: 运行文档相关最终验证**
Run: `nix flake check && nix run .#xxvim -- --headless '+qa'`
Expected: 全部通过。

**Step 4: Commit**
```bash
git add README.md flake.nix
git commit -m "docs: 补充 xxvim 的模块与包使用方式"
```

### Task 5: 可选增强——增加启用包装层

**Files:**
- Create: `modules/home/default.nix` 或 `config/home-module.nix`
- Modify: `flake.nix`
- Modify: `README.md`

**Step 1: 评估是否需要 `xxvim.enable` 包装层**
- 只有在你明确需要“可开关启用”“附加 home.packages / sessionVariables / shell 别名”时才增加。
- 如果只是导入 nixvim 模块本身，则先不要做，遵循 YAGNI。

**Step 2: 若需要再实现最小包装**
- 提供：
  - `options.xxvim.enable`
  - `config = lib.mkIf cfg.enable { ... }`
- 包装层内部仍复用 `config/` 真源，不复制插件配置。

**Step 3: 再次验证**
Run: `nix flake check`
Expected: 通过；包装层未破坏原始使用方式。

**Step 4: Commit**
```bash
git add modules/home/default.nix flake.nix README.md
git commit -m "feat: 为 xxvim 增加可选 home-manager 包装层"
```

### Task 6: 最终收口与验收

**Files:**
- Inspect: `flake.nix`
- Inspect: `README.md`
- Inspect: `docs/plans/2026-03-08-home-modules-and-packages.md`

**Step 1: 验收输出语义**
- 确认以下命令/用法成立：
  - `nix run .#xxvim`
  - `nix run .#xxvim -- --headless '+qa'`
  - Home Manager 中 `imports = [ inputs.xxvim.homeModules.default ]`

**Step 2: 执行最终验证**
Run: `nix flake check`
Expected: PASS。

Run: `nix run .#xxvim -- --headless '+qa'`
Expected: PASS。

**Step 3: 整理最终提交**
```bash
git add flake.nix README.md docs/plans/2026-03-08-home-modules-and-packages.md
git commit -m "feat: 同时提供 xxvim 的模块与包输出"
```

## 实施建议
- 第一阶段只做 `homeModules.default + 保持 packages 不变 + README 示例`，这是最小闭环。
- `homeManagerModules.default` 作为兼容别名可选添加，但不要为兼容性引入过多结构复杂度。
- `xxvim.enable` 包装层属于第二阶段能力，只有在你需要额外 HM 集成逻辑时再加。

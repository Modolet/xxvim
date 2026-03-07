# Repository Guidelines

## Project Structure & Module Organization
- `flake.nix` is the entry point. It defines the `xxvim` package, checks, and the development shell.
- `config/` contains the NixVim module tree. Keep feature areas split by concern: `core.nix`, `ui.nix`, `editor.nix`, `coding.nix`, `languages.nix`, `dap.nix`, and `keymaps.nix`.
- `config/lua/xxvim/` contains runtime Lua behavior that is loaded from Nix modules. Add new workflow logic here rather than embedding large Lua blocks inline.
- `docs/plans/` stores design notes and implementation plans for substantial changes.

## Build, Test, and Development Commands
- `nix run .#xxvim` — launch the packaged editor.
- `nix develop` — open a shell with the same toolchain exposed to the editor.
- `nix flake check` — primary validation command; run after every change.
- `nix run .#xxvim -- --headless '+qa'` — smoke-test startup without opening the UI.

## Coding Style & Naming Conventions
- Use 2-space indentation in both Nix and Lua files; do not introduce tabs.
- Keep modules focused and small. Prefer adding a new file under `config/` or `config/lua/xxvim/` over growing a catch-all file.
- Use descriptive snake_case names for Lua helpers and lowercase module filenames such as `workflow.lua` or `languages.nix`.
- Prefer declarative NixVim options first; fall back to Lua only when the Nix module layer is insufficient.

## Testing Guidelines
- There is no separate unit test suite yet. Validation is command-based.
- Minimum verification for any config change:
  - `nix flake check`
  - `nix run .#xxvim -- --headless '+qa'`
- If you change startup UI, keymaps, or plugin wiring, also manually open `nix run .#xxvim` and confirm the feature behaves as expected.

## Commit & Pull Request Guidelines
- Follow Conventional Commits, matching existing history: `feat: ...`, `fix: ...`.
- Commit messages in this repository use concise Chinese summaries, for example: `fix: 修正 which-key 分组名称显示`.
- PRs should include: purpose, key files changed, validation commands run, and screenshots for UI/dashboard updates.

## Configuration Notes
- Avoid Mason-style runtime downloads; prefer packaging tools through Nix.
- Keep dashboard text, keymap labels, and UI-facing strings consistent and intentional across Nix and Lua layers.

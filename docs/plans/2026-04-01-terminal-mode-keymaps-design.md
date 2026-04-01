# 终端模式按键调整设计

**背景**

当前 `xxvim` 的内置终端按键仅在 `config/lua/xxvim/terminal.lua` 中为自身创建的终端缓冲区设置，无法覆盖其他 `terminal` buffer。用户希望所有终端缓冲区都具备一致行为：

- 终端模式下使用 `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` 切换窗口焦点
- 终端模式下快速连按 `<Esc>` 退出到 normal 模式

**设计选择**

采用通用 Lua 自动命令方案，在 `TermOpen` 时为所有终端缓冲区绑定统一键位，而不是只对 `xxvim` 内置终端追加局部映射。

**方案说明**

- 在 `config/lua/xxvim/terminal.lua` 中增加一个面向所有终端缓冲区的按键绑定函数。
- 在 `setup_commands()` 中注册 `TermOpen` 自动命令，确保任何终端缓冲区打开时都自动获得相同映射。
- 内置终端继续复用同一套终端缓冲区按键绑定，避免规则分叉。

**行为细节**

- `<C-h/j/k/l>` 在 terminal mode 下先发送 `<C-\><C-n>` 离开 job 输入，再执行窗口跳转。
- `<Esc><Esc>` 在 terminal mode 下切回 normal mode。
- 保留现有内置终端的 `q` 关闭窗口与 `<C-q>` 关闭终端行为。

**验证方式**

- `nix flake check`
- `nix run .#xxvim -- --headless '+qa'`

local ok_dap, dap = pcall(require, "dap")
local ok_dapui, dapui = pcall(require, "dapui")
local ok_virtual, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")

if ok_dapui then
  dapui.setup({
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.55 },
          { id = "breakpoints", size = 0.15 },
          { id = "stacks", size = 0.15 },
          { id = "watches", size = 0.15 },
        },
        size = 40,
        position = "left",
      },
      {
        elements = {
          { id = "repl", size = 0.5 },
          { id = "console", size = 0.5 },
        },
        size = 10,
        position = "bottom",
      },
    },
  })
end

if ok_virtual then
  dap_virtual_text.setup({})
end

if ok_dap and ok_dapui then
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
  end

  dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
  }

  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      pythonPath = function()
        return "python"
      end,
      console = "integratedTerminal",
    },
  }

  dap.adapters.lldb = {
    type = "executable",
    command = "lldb-vscode",
    name = "lldb",
  }

  local native_config = {
    {
      name = "Launch file",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      runInTerminal = false,
    },
  }

  dap.configurations.rust = native_config
  dap.configurations.c = native_config
  dap.configurations.cpp = native_config

  vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
  vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignHint", linehl = "Visual", numhl = "" })
end

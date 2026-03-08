local M = {}

local dap_ready = false
local dap
local dapui

local function ensure_dap()
  if dap_ready then
    return true, dap, dapui
  end

  local ok_dap
  ok_dap, dap = pcall(require, "dap")
  if not ok_dap then
    return false
  end

  local ok_dapui
  ok_dapui, dapui = pcall(require, "dapui")

  if ok_dapui then
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end
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
    command = "lldb-dap",
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

  dap_ready = true
  return true, dap, dapui
end

local function with_dap(callback)
  local ok, dap_instance, dapui_instance = ensure_dap()
  if not ok then
    vim.notify("DAP 当前不可用", vim.log.levels.WARN)
    return
  end

  callback(dap_instance, dapui_instance)
end

function M.run_with_args()
  with_dap(function(dap_instance)
    local config = dap_instance.configurations[vim.bo.filetype] and dap_instance.configurations[vim.bo.filetype][1]
    if not config then
      vim.notify("No DAP configuration for current filetype", vim.log.levels.WARN)
      return
    end
    local args = vim.fn.input("Args: ")
    local cfg = vim.deepcopy(config)
    cfg.args = args ~= "" and vim.split(args, " ") or {}
    dap_instance.run(cfg)
  end)
end

function M.toggle_breakpoint()
  with_dap(function(dap_instance)
    dap_instance.toggle_breakpoint()
  end)
end

function M.set_conditional_breakpoint()
  with_dap(function(dap_instance)
    dap_instance.set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end)
end

function M.set_log_point()
  with_dap(function(dap_instance)
    dap_instance.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
  end)
end

function M.continue()
  with_dap(function(dap_instance)
    dap_instance.continue()
  end)
end

function M.toggle_repl()
  with_dap(function(dap_instance)
    dap_instance.repl.toggle()
  end)
end

function M.run_last()
  with_dap(function(dap_instance)
    dap_instance.run_last()
  end)
end

function M.toggle_ui()
  with_dap(function(_, dapui_instance)
    if dapui_instance then
      dapui_instance.toggle({})
    end
  end)
end

function M.terminate()
  with_dap(function(dap_instance)
    dap_instance.terminate()
  end)
end

function M.step_over()
  with_dap(function(dap_instance)
    dap_instance.step_over()
  end)
end

function M.step_into()
  with_dap(function(dap_instance)
    dap_instance.step_into()
  end)
end

function M.step_out()
  with_dap(function(dap_instance)
    dap_instance.step_out()
  end)
end

return M

{ ... }:
{
  config.keymaps = [
      {
        mode = "n";
        key = "<leader>da";
        action = "<cmd>lua require('xxvim.dap').run_with_args()<cr>";
        options.desc = "Run with Args";
      }
      {
        mode = "n";
        key = "<leader>db";
        action = "<cmd>lua require('xxvim.dap').toggle_breakpoint()<cr>";
        options.desc = "Toggle Breakpoint";
      }
      {
        mode = "n";
        key = "<leader>dB";
        action = "<cmd>lua require('xxvim.dap').set_conditional_breakpoint()<cr>";
        options.desc = "Conditional Breakpoint";
      }
      {
        mode = "n";
        key = "<leader>dL";
        action = "<cmd>lua require('xxvim.dap').set_log_point()<cr>";
        options.desc = "Log Point";
      }
      {
        mode = "n";
        key = "<leader>dc";
        action = "<cmd>lua require('xxvim.dap').continue()<cr>";
        options.desc = "Debug Continue";
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = "<cmd>lua require('xxvim.dap').toggle_repl()<cr>";
        options.desc = "Toggle REPL";
      }
      {
        mode = "n";
        key = "<leader>dl";
        action = "<cmd>lua require('xxvim.dap').run_last()<cr>";
        options.desc = "Run Last";
      }
      {
        mode = "n";
        key = "<leader>du";
        action = "<cmd>lua require('xxvim.dap').toggle_ui()<cr>";
        options.desc = "Debug UI";
      }
      {
        mode = "n";
        key = "<leader>dt";
        action = "<cmd>lua require('xxvim.dap').terminate()<cr>";
        options.desc = "Terminate";
      }
      {
        mode = "n";
        key = "<leader>do";
        action = "<cmd>lua require('xxvim.dap').step_over()<cr>";
        options.desc = "Step Over";
      }
      {
        mode = "n";
        key = "<leader>di";
        action = "<cmd>lua require('xxvim.dap').step_into()<cr>";
        options.desc = "Step Into";
      }
      {
        mode = "n";
        key = "<leader>dO";
        action = "<cmd>lua require('xxvim.dap').step_out()<cr>";
        options.desc = "Step Out";
      }
      {
        mode = "n";
        key = "<leader>dR";
        action = "<cmd>lua require('xxvim.dap').toggle_repl()<cr>";
        options.desc = "REPL";
      }
      {
        mode = "n";
        key = "<leader>tt";
        action = "<cmd>OverseerToggle<cr>";
        options.desc = "Task List";
      }
      {
        mode = "n";
        key = "<leader>tr";
        action = "<cmd>OverseerRun<cr>";
        options.desc = "Run Task";
      }
      {
        mode = "n";
        key = "<leader>tn";
        action = "<cmd>lua require('xxvim.testing').run_nearest()<cr>";
        options.desc = "Run Nearest Test";
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>lua require('xxvim.testing').run_file()<cr>";
        options.desc = "Run Test File";
      }
      {
        mode = "n";
        key = "<leader>tS";
        action = "<cmd>lua require('xxvim.testing').toggle_summary()<cr>";
        options.desc = "Test Summary";
      }
      {
        mode = "n";
        key = "<leader>to";
        action = "<cmd>lua require('xxvim.testing').open_output()<cr>";
        options.desc = "Test Output";
      }
      {
        mode = "n";
        key = "<leader>td";
        action = "<cmd>lua require('xxvim.testing').debug_nearest()<cr>";
        options.desc = "Debug Nearest Test";
      }
      {
        mode = "n";
        key = "<leader>T";
        action = "<cmd>XxvimFloatTerm<cr>";
        options.desc = "Terminal (cwd)";
      }
      {
        mode = [ "n" "t" ];
        key = "<C-.>";
        action = "<cmd>XxvimFloatTerm<cr>";
        options.desc = "Float Terminal";
      }
      {
        mode = [ "n" "t" ];
        key = "<C-/>";
        action = "<cmd>XxvimBottomTerm<cr>";
        options.desc = "Bottom Terminal";
      }
      {
        mode = "n";
        key = "<leader>tb";
        action = "<cmd>XxvimBottomTerm<cr>";
        options.desc = "Bottom Terminal";
      }
  ];
}

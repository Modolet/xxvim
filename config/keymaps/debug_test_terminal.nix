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
        action = "<cmd>lua require('dap').toggle_breakpoint()<cr>";
        options.desc = "Toggle Breakpoint";
      }
      {
        mode = "n";
        key = "<leader>dB";
        action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>";
        options.desc = "Conditional Breakpoint";
      }
      {
        mode = "n";
        key = "<leader>dL";
        action = "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>";
        options.desc = "Log Point";
      }
      {
        mode = "n";
        key = "<leader>dc";
        action = "<cmd>lua require('dap').continue()<cr>";
        options.desc = "Debug Continue";
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = "<cmd>lua require('dap').repl.toggle()<cr>";
        options.desc = "Toggle REPL";
      }
      {
        mode = "n";
        key = "<leader>dl";
        action = "<cmd>lua require('dap').run_last()<cr>";
        options.desc = "Run Last";
      }
      {
        mode = "n";
        key = "<leader>du";
        action = "<cmd>lua require('dapui').toggle()<cr>";
        options.desc = "Debug UI";
      }
      {
        mode = "n";
        key = "<leader>dt";
        action = "<cmd>lua require('dap').terminate()<cr>";
        options.desc = "Terminate";
      }
      {
        mode = "n";
        key = "<leader>do";
        action = "<cmd>lua require('dap').step_over()<cr>";
        options.desc = "Step Over";
      }
      {
        mode = "n";
        key = "<leader>di";
        action = "<cmd>lua require('dap').step_into()<cr>";
        options.desc = "Step Into";
      }
      {
        mode = "n";
        key = "<leader>dO";
        action = "<cmd>lua require('dap').step_out()<cr>";
        options.desc = "Step Out";
      }
      {
        mode = "n";
        key = "<leader>dR";
        action = "<cmd>lua require('dap').repl.toggle()<cr>";
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
        action = "<cmd>lua require('neotest').run.run()<cr>";
        options.desc = "Run Nearest Test";
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>";
        options.desc = "Run Test File";
      }
      {
        mode = "n";
        key = "<leader>tS";
        action = "<cmd>lua require('neotest').summary.toggle()<cr>";
        options.desc = "Test Summary";
      }
      {
        mode = "n";
        key = "<leader>to";
        action = "<cmd>lua require('neotest').output.open({ enter = true, auto_close = true })<cr>";
        options.desc = "Test Output";
      }
      {
        mode = "n";
        key = "<leader>td";
        action = "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<cr>";
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

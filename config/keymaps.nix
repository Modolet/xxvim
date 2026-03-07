{ ... }:
{
  config = {
    globals.mapleader = " ";
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>lua Snacks.explorer()<cr>";
        options.desc = "Explorer";
      }
      {
        mode = "n";
        key = "<leader><space>";
        action = "<cmd>lua Snacks.picker.smart()<cr>";
        options.desc = "Smart Find Files";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>lua Snacks.picker.files()<cr>";
        options.desc = "Find Files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>lua Snacks.picker.grep()<cr>";
        options.desc = "Grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>lua Snacks.picker.buffers()<cr>";
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>lua Snacks.picker.recent()<cr>";
        options.desc = "Recent";
      }
      {
        mode = "n";
        key = "<leader>f/";
        action = "<cmd>lua Snacks.picker.lines()<cr>";
        options.desc = "Buffer Lines";
      }
      {
        mode = "n";
        key = "<leader>gc";
        action = "<cmd>lua Snacks.picker.git_log()<cr>";
        options.desc = "Git Log";
      }
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>lua Snacks.picker.git_status()<cr>";
        options.desc = "Git Status";
      }
      {
        mode = "n";
        key = "<leader>sd";
        action = "<cmd>lua Snacks.picker.diagnostics()<cr>";
        options.desc = "Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>sD";
        action = "<cmd>lua Snacks.picker.diagnostics_buffer()<cr>";
        options.desc = "Buffer Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>ss";
        action = "<cmd>lua Snacks.picker.lsp_symbols()<cr>";
        options.desc = "Document Symbols";
      }
      {
        mode = "n";
        key = "<leader>sS";
        action = "<cmd>lua Snacks.picker.lsp_workspace_symbols()<cr>";
        options.desc = "Workspace Symbols";
      }
      {
        mode = [ "n" "v" ];
        key = "gy";
        action = "<cmd>YankyRingHistory<cr>";
        options.desc = "Yank history";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = ":IncRename ";
        options.desc = "Incremental Rename";
      }
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options.desc = "Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        options.desc = "Buffer Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>lua vim.lsp.buf.signature_help()<cr>";
        options.desc = "Signature Help";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
        options.desc = "Code Action";
      }
      {
        mode = "n";
        key = "[d";
        action = "<cmd>lua vim.diagnostic.goto_prev()<cr>";
        options.desc = "Prev Diagnostic";
      }
      {
        mode = "n";
        key = "]d";
        action = "<cmd>lua vim.diagnostic.goto_next()<cr>";
        options.desc = "Next Diagnostic";
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
        key = "<leader>dl";
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
    ];
  };
}

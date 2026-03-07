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
        key = "<leader>fp";
        action = "<cmd>XxvimRecentProjects<cr>";
        options.desc = "Projects";
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
        key = "<leader>gC";
        action = "<cmd>lua Snacks.picker.git_log_line()<cr>";
        options.desc = "Git Log Line";
      }
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>lua Snacks.picker.git_status()<cr>";
        options.desc = "Git Status";
      }
      {
        mode = "n";
        key = "<leader>gB";
        action = "<cmd>lua xxvim_workflow.git_blame_line()<cr>";
        options.desc = "Git Blame Line";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>lua xxvim_workflow.git_diff_this()<cr>";
        options.desc = "Git Diff This";
      }
      {
        mode = "n";
        key = "]h";
        action = "<cmd>lua require('gitsigns').next_hunk()<cr>";
        options.desc = "Next Hunk";
      }
      {
        mode = "n";
        key = "[h";
        action = "<cmd>lua require('gitsigns').prev_hunk()<cr>";
        options.desc = "Prev Hunk";
      }
      {
        mode = [ "n" "v" ];
        key = "<leader>ghs";
        action = "<cmd>lua require('gitsigns').stage_hunk()<cr>";
        options.desc = "Stage Hunk";
      }
      {
        mode = [ "n" "v" ];
        key = "<leader>ghr";
        action = "<cmd>lua require('gitsigns').reset_hunk()<cr>";
        options.desc = "Reset Hunk";
      }
      {
        mode = "n";
        key = "<leader>ghp";
        action = "<cmd>lua require('gitsigns').preview_hunk_inline()<cr>";
        options.desc = "Preview Hunk";
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
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>XxvimFloatTerm<cr>";
        options.desc = "Float Terminal";
      }
      {
        mode = "n";
        key = "<leader>tb";
        action = "<cmd>XxvimBottomTerm<cr>";
        options.desc = "Bottom Terminal";
      }
      {
        mode = "n";
        key = "<leader>ws";
        action = "<cmd>split<cr>";
        options.desc = "Split Below";
      }
      {
        mode = "n";
        key = "<leader>wv";
        action = "<cmd>vsplit<cr>";
        options.desc = "Split Right";
      }
      {
        mode = "n";
        key = "<leader>wd";
        action = "<cmd>close<cr>";
        options.desc = "Delete Window";
      }
      {
        mode = "n";
        key = "<leader>wo";
        action = "<cmd>only<cr>";
        options.desc = "Only Window";
      }
      {
        mode = "n";
        key = "<leader>w=";
        action = "<C-w>=";
        options.desc = "Equalize Windows";
      }
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options.desc = "Prev Buffer";
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>BufferLineCycleNext<cr>";
        options.desc = "Next Buffer";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<cr>";
        options.desc = "Delete Buffer";
      }
      {
        mode = "n";
        key = "<leader>bo";
        action = "<cmd>lua xxvim_workflow.close_other_buffers()<cr>";
        options.desc = "Delete Other Buffers";
      }
      {
        mode = "n";
        key = "<leader>qs";
        action = "<cmd>XxvimSessionSave<cr>";
        options.desc = "Save Session";
      }
      {
        mode = "n";
        key = "<leader>qr";
        action = "<cmd>XxvimSessionRestore<cr>";
        options.desc = "Restore Session";
      }
    ];
  };
}

{ ... }:
{
  config.keymaps = [
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
        key = "<leader>sg";
        action = "<cmd>lua Snacks.picker.grep({ cwd = require('xxvim.root').project_root() })<cr>";
        options.desc = "Grep (Root Dir)";
      }
      {
        mode = "n";
        key = "<leader>sG";
        action = "<cmd>lua Snacks.picker.grep({ cwd = vim.uv.cwd() })<cr>";
        options.desc = "Grep (cwd)";
      }
      {
        mode = "n";
        key = "<leader>sb";
        action = "<cmd>lua Snacks.picker.lines()<cr>";
        options.desc = "Buffer Lines";
      }
      {
        mode = "n";
        key = "<leader>sB";
        action = "<cmd>lua Snacks.picker.grep_buffers()<cr>";
        options.desc = "Grep Open Buffers";
      }
      {
        mode = "n";
        key = "<leader>sc";
        action = "<cmd>lua Snacks.picker.command_history()<cr>";
        options.desc = "Command History";
      }
      {
        mode = "n";
        key = "<leader>sC";
        action = "<cmd>lua Snacks.picker.commands()<cr>";
        options.desc = "Commands";
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<cmd>lua Snacks.picker.help()<cr>";
        options.desc = "Help Pages";
      }
      {
        mode = "n";
        key = "<leader>sk";
        action = "<cmd>lua Snacks.picker.keymaps()<cr>";
        options.desc = "Keymaps";
      }
      {
        mode = "n";
        key = "<leader>sl";
        action = "<cmd>lua Snacks.picker.loclist()<cr>";
        options.desc = "Location List";
      }
      {
        mode = "n";
        key = "<leader>sq";
        action = "<cmd>lua Snacks.picker.qflist()<cr>";
        options.desc = "Quickfix List";
      }
      {
        mode = "n";
        key = "<leader>sr";
        action = "<cmd>lua Snacks.picker.resume()<cr>";
        options.desc = "Resume";
      }
      {
        mode = "n";
        key = "<leader>st";
        action = "<cmd>TodoTrouble<cr>";
        options.desc = "Todo";
      }
      {
        mode = [ "n" "v" ];
        key = "<leader>sw";
        action = "<cmd>lua Snacks.picker.grep_word({ cwd = require('xxvim.root').project_root() })<cr>";
        options.desc = "Visual selection or word (Root Dir)";
      }
      {
        mode = "n";
        key = "<leader>ss";
        action = "<cmd>lua Snacks.picker.lsp_symbols()<cr>";
        options.desc = "LSP Symbols";
      }
      {
        mode = "n";
        key = "<leader>sS";
        action = "<cmd>lua Snacks.picker.lsp_workspace_symbols()<cr>";
        options.desc = "LSP Workspace Symbols";
      }
      {
        mode = [ "n" "v" ];
        key = "<leader>sy";
        action = "<cmd>YankyRingHistory<cr>";
        options.desc = "Yank History";
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>lua Snacks.picker.lsp_symbols()<cr>";
        options.desc = "Symbols (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cS";
        action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
        options.desc = "LSP Definitions / References / ...";
      }
      {
        mode = "n";
        key = "<leader>cl";
        action = "<cmd>LspInfo<cr>";
        options.desc = "Lsp Info";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
        options.desc = "Code Action";
      }
      {
        mode = "n";
        key = "<leader>cA";
        action = "<cmd>lua vim.lsp.buf.code_action({ context = { only = { 'source' }, diagnostics = {} } })<cr>";
        options.desc = "Source Action";
      }
      {
        mode = "n";
        key = "<leader>cc";
        action = "<cmd>lua vim.lsp.codelens.run()<cr>";
        options.desc = "Run Codelens";
      }
      {
        mode = "n";
        key = "<leader>cC";
        action = "<cmd>lua vim.lsp.codelens.refresh()<cr>";
        options.desc = "Refresh & Display Codelens";
      }
      {
        mode = "n";
        key = "<leader>cd";
        action = "<cmd>lua vim.diagnostic.open_float()<cr>";
        options.desc = "Line Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>cr";
        action = ":IncRename <C-r><C-w>";
        options.desc = "Rename";
        options.silent = true;
      }
      {
        mode = "n";
        key = "gD";
        action = "<cmd>lua vim.lsp.buf.declaration()<cr>";
        options.desc = "Goto Declaration";
      }
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<cr>";
        options.desc = "Goto Definition";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua Snacks.picker.lsp_references()<cr>";
        options.desc = "References";
      }
      {
        mode = "n";
        key = "gI";
        action = "<cmd>lua vim.lsp.buf.implementation()<cr>";
        options.desc = "Goto Implementation";
      }
      {
        mode = "n";
        key = "gy";
        action = "<cmd>lua vim.lsp.buf.type_definition()<cr>";
        options.desc = "Goto Type Definition";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<cr>";
        options.desc = "Hover";
      }
      {
        mode = "n";
        key = "gK";
        action = "<cmd>lua vim.lsp.buf.signature_help()<cr>";
        options.desc = "Signature Help";
      }
      {
        mode = "i";
        key = "<C-k>";
        action = "<cmd>lua vim.lsp.buf.signature_help()<cr>";
        options.desc = "Signature Help";
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
        key = "[e";
        action = "<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>";
        options.desc = "Prev Error";
      }
      {
        mode = "n";
        key = "]e";
        action = "<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>";
        options.desc = "Next Error";
      }
      {
        mode = "n";
        key = "[w";
        action = "<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })<cr>";
        options.desc = "Prev Warning";
      }
      {
        mode = "n";
        key = "]w";
        action = "<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })<cr>";
        options.desc = "Next Warning";
      }
      {
        mode = "n";
        key = "<leader>xr";
        action = "<cmd>Trouble lsp_references toggle<cr>";
        options.desc = "LSP References (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xs";
        action = "<cmd>Trouble symbols toggle focus=false<cr>";
        options.desc = "Symbols (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xl";
        action = "<cmd>Trouble loclist toggle<cr>";
        options.desc = "Location List (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xL";
        action = "<cmd>Trouble loclist toggle<cr>";
        options.desc = "Location List (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xq";
        action = "<cmd>Trouble qflist toggle<cr>";
        options.desc = "Quickfix List (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xQ";
        action = "<cmd>Trouble qflist toggle<cr>";
        options.desc = "Quickfix List (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xt";
        action = "<cmd>TodoTrouble<cr>";
        options.desc = "Todo (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xT";
        action = "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>";
        options.desc = "Todo/Fix/Fixme (Trouble)";
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
        key = "[q";
        action = "<cmd>cprev<cr>";
        options.desc = "Previous Quickfix";
      }
      {
        mode = "n";
        key = "]q";
        action = "<cmd>cnext<cr>";
        options.desc = "Next Quickfix";
      }
  ];
}

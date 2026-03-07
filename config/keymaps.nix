{ ... }:
{
  config = {
    globals.mapleader = " ";
    keymaps = [
      {
        mode = [ "n" "i" "x" "s" ];
        key = "<C-s>";
        action = "<cmd>w<cr><esc>";
        options.desc = "Save File";
      }
      {
        mode = "n";
        key = "<leader>ur";
        action = "<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-L><cr>";
        options.desc = "Redraw / Clear hlsearch / Diff Update";
      }
      {
        mode = "n";
        key = "<leader>K";
        action = "K";
        options.desc = "Keywordprg";
      }
      {
        mode = "n";
        key = "<leader>l";
        action = "<cmd>checkhealth<cr>";
        options.desc = "Health";
      }
      {
        mode = "n";
        key = "gco";
        action = "o<Esc>Vcx<Esc><cmd>normal gcc<cr>fxa<BS>";
        options.desc = "Add Comment Below";
      }
      {
        mode = "n";
        key = "gcO";
        action = "O<Esc>Vcx<Esc><cmd>normal gcc<cr>fxa<BS>";
        options.desc = "Add Comment Above";
      }
      {
        mode = [ "n" "i" "s" ];
        key = "<Esc>";
        action = "<cmd>nohlsearch<bar>echo<cr><esc>";
        options.desc = "Escape and Clear hlsearch";
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Go to Left Window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Go to Lower Window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Go to Upper Window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Go to Right Window";
      }
      {
        mode = "n";
        key = "<C-Up>";
        action = "<cmd>resize +2<cr>";
        options.desc = "Increase Window Height";
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = "<cmd>resize -2<cr>";
        options.desc = "Decrease Window Height";
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = "<cmd>vertical resize -2<cr>";
        options.desc = "Decrease Window Width";
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = "<cmd>vertical resize +2<cr>";
        options.desc = "Increase Window Width";
      }
      {
        mode = "n";
        key = "<A-j>";
        action = "<cmd>m .+1<cr>==";
        options.desc = "Move Down";
      }
      {
        mode = "n";
        key = "<A-k>";
        action = "<cmd>m .-2<cr>==";
        options.desc = "Move Up";
      }
      {
        mode = "i";
        key = "<A-j>";
        action = "<esc><cmd>m .+1<cr>==gi";
        options.desc = "Move Down";
      }
      {
        mode = "i";
        key = "<A-k>";
        action = "<esc><cmd>m .-2<cr>==gi";
        options.desc = "Move Up";
      }
      {
        mode = "v";
        key = "<A-j>";
        action = ":m '>+1<cr>gv=gv";
        options.desc = "Move Down";
      }
      {
        mode = "v";
        key = "<A-k>";
        action = ":m '<-2<cr>gv=gv";
        options.desc = "Move Up";
      }
      {
        mode = "n";
        key = "<C-a>";
        action.__raw = "function() require('dial.map').manipulate('increment', 'normal') end";
        options.desc = "Increment";
      }
      {
        mode = "n";
        key = "<C-x>";
        action.__raw = "function() require('dial.map').manipulate('decrement', 'normal') end";
        options.desc = "Decrement";
      }
      {
        mode = "n";
        key = "<leader>,";
        action = "<cmd>lua Snacks.picker.buffers()<cr>";
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>:";
        action = "<cmd>lua Snacks.picker.command_history()<cr>";
        options.desc = "Command History";
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>lua Snacks.picker.grep({ cwd = xxvim_root() })<cr>";
        options.desc = "Grep (Root Dir)";
      }
      {
        mode = "n";
        key = "<leader>.";
        action = "<cmd>lua require('snacks').scratch.open()<cr>";
        options.desc = "Toggle Scratch Buffer";
      }
      {
        mode = "n";
        key = "<leader>?";
        action = "<cmd>lua Snacks.picker.keymaps({ buffer = 0 })<cr>";
        options.desc = "Buffer Keymaps";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>lua require('snacks').explorer.open({ cwd = xxvim_root() })<cr>";
        options.desc = "Explorer (Root Dir)";
      }
      {
        mode = "n";
        key = "<leader>E";
        action = "<cmd>lua require('snacks').explorer.open({ cwd = vim.uv.cwd() })<cr>";
        options.desc = "Explorer (cwd)";
      }
      {
        mode = "n";
        key = "<leader><space>";
        action = "<cmd>lua Snacks.picker.files({ cwd = xxvim_root() })<cr>";
        options.desc = "Find Files (Root Dir)";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>lua Snacks.picker.files({ cwd = xxvim_root() })<cr>";
        options.desc = "Find Files (Root Dir)";
      }
      {
        mode = "n";
        key = "<leader>fF";
        action = "<cmd>lua Snacks.picker.files({ cwd = vim.uv.cwd() })<cr>";
        options.desc = "Find Files (cwd)";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>lua Snacks.picker.git_files({ cwd = xxvim_root() })<cr>";
        options.desc = "Find Files (git-files)";
      }
      {
        mode = "n";
        key = "<leader>fG";
        action = "<cmd>lua Snacks.picker.grep({ cwd = vim.uv.cwd() })<cr>";
        options.desc = "Grep (cwd)";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>lua Snacks.picker.buffers()<cr>";
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>fB";
        action = "<cmd>lua Snacks.picker.buffers({ hidden = true, unloaded = true })<cr>";
        options.desc = "All Buffers";
      }
      {
        mode = "n";
        key = "<leader>fc";
        action = "<cmd>lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })<cr>";
        options.desc = "Find Config File";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>lua Snacks.picker.recent()<cr>";
        options.desc = "Recent";
      }
      {
        mode = "n";
        key = "<leader>fR";
        action = "<cmd>lua Snacks.picker.recent({ filter = { cwd = true } })<cr>";
        options.desc = "Recent (cwd)";
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
        key = "<leader>fn";
        action = "<cmd>ene<cr>";
        options.desc = "New File";
      }
      {
        mode = "n";
        key = "<leader>gc";
        action = "<cmd>lua Snacks.picker.git_log()<cr>";
        options.desc = "Git Log";
      }
      {
        mode = "n";
        key = "<leader>gL";
        action = "<cmd>lua Snacks.picker.git_log({ cwd = vim.uv.cwd() })<cr>";
        options.desc = "Git Log (cwd)";
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
        key = "<leader>gS";
        action = "<cmd>lua Snacks.picker.git_stash()<cr>";
        options.desc = "Git Stash";
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>XxvimLazyGit<cr>";
        options.desc = "LazyGit";
      }
      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>lua _G.xxvim_workflow.git_blame_line()<cr>";
        options.desc = "Git Blame Line";
      }
      {
        mode = "n";
        key = "<leader>gB";
        action = "<cmd>lua require('snacks').gitbrowse.open()<cr>";
        options.desc = "Git Browse";
      }
      {
        mode = "n";
        key = "<leader>gf";
        action = "<cmd>lua Snacks.picker.git_log_file()<cr>";
        options.desc = "Git Current File History";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>lua _G.xxvim_workflow.git_diff_this()<cr>";
        options.desc = "Git Diff (Hunks)";
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
        key = "<leader>sg";
        action = "<cmd>lua Snacks.picker.grep({ cwd = xxvim_root() })<cr>";
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
        action = "<cmd>lua Snacks.picker.grep_word({ cwd = xxvim_root() })<cr>";
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
        action = ":IncRename ";
        options.desc = "Rename";
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
      {
        mode = "n";
        key = "<leader>uf";
        action = "<cmd>lua xxvim_toggle_autoformat_global()<cr>";
        options.desc = "Toggle Auto Format (Global)";
      }
      {
        mode = "n";
        key = "<leader>uF";
        action = "<cmd>lua xxvim_toggle_autoformat_buffer()<cr>";
        options.desc = "Toggle Auto Format (Buffer)";
      }
      {
        mode = "n";
        key = "<leader>uh";
        action = "<cmd>lua xxvim_toggle_inlay_hints()<cr>";
        options.desc = "Toggle Inlay Hints";
      }
      {
        mode = "n";
        key = "<leader>ud";
        action = "<cmd>lua xxvim_toggle_diagnostics()<cr>";
        options.desc = "Toggle Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>ul";
        action = "<cmd>lua xxvim_toggle_option('number', true, false, 'wo')<cr>";
        options.desc = "Toggle Line Numbers";
      }
      {
        mode = "n";
        key = "<leader>uL";
        action = "<cmd>lua xxvim_toggle_option('relativenumber', true, false, 'wo')<cr>";
        options.desc = "Toggle Relative Number";
      }
      {
        mode = "n";
        key = "<leader>uw";
        action = "<cmd>lua xxvim_toggle_option('wrap', true, false, 'wo')<cr>";
        options.desc = "Toggle Wrap";
      }
      {
        mode = "n";
        key = "<leader>us";
        action = "<cmd>lua xxvim_toggle_option('spell', true, false, 'wo')<cr>";
        options.desc = "Toggle Spelling";
      }
      {
        mode = "n";
        key = "<leader>uc";
        action = "<cmd>lua xxvim_toggle_conceal()<cr>";
        options.desc = "Toggle Conceal Level";
      }
      {
        mode = "n";
        key = "<leader>uA";
        action = "<cmd>lua xxvim_toggle_tabline()<cr>";
        options.desc = "Toggle Tabline";
      }
      {
        mode = "n";
        key = "<leader>ub";
        action = "<cmd>lua xxvim_toggle_background()<cr>";
        options.desc = "Toggle Dark Background";
      }
      {
        mode = "n";
        key = "<leader>ug";
        action = "<cmd>lua xxvim_toggle_indent_guides()<cr>";
        options.desc = "Toggle Indent Guides";
      }
      {
        mode = "n";
        key = "<leader>uT";
        action = "<cmd>lua xxvim_toggle_treesitter_highlight()<cr>";
        options.desc = "Toggle Treesitter Highlight";
      }
      {
        mode = "n";
        key = "[t";
        action = "<cmd>lua require('todo-comments').jump_prev()<cr>";
        options.desc = "Previous Todo Comment";
      }
      {
        mode = "n";
        key = "]t";
        action = "<cmd>lua require('todo-comments').jump_next()<cr>";
        options.desc = "Next Todo Comment";
      }
      {
        mode = "n";
        key = "<leader>uC";
        action = "<cmd>lua Snacks.picker.colorschemes()<cr>";
        options.desc = "Colorschemes";
      }
      {
        mode = "n";
        key = "<leader>un";
        action = "<cmd>lua require('noice').cmd('dismiss')<cr>";
        options.desc = "Dismiss All Notifications";
      }
      {
        mode = "n";
        key = "<leader>ui";
        action = "<cmd>Inspect<cr>";
        options.desc = "Inspect Pos";
      }
      {
        mode = "n";
        key = "<leader>uI";
        action = "<cmd>InspectTree<cr>";
        options.desc = "Inspect Tree";
      }
      {
        mode = "n";
        key = "<leader>uZ";
        action = "<cmd>XxvimToggleZoom<cr>";
        options.desc = "Toggle Zoom Mode";
      }
      {
        mode = "n";
        key = "<leader>da";
        action = "<cmd>lua xxvim_dap_run_with_args()<cr>";
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
        key = "<C-/>";
        action = "<cmd>XxvimFloatTerm<cr>";
        options.desc = "Terminal (Root Dir)";
      }
      {
        mode = "n";
        key = "<leader>tb";
        action = "<cmd>XxvimBottomTerm<cr>";
        options.desc = "Bottom Terminal";
      }
      {
        mode = "n";
        key = "<leader>-";
        action = "<cmd>split<cr>";
        options.desc = "Split Window Below";
      }
      {
        mode = "n";
        key = "<leader>|";
        action = "<cmd>vsplit<cr>";
        options.desc = "Split Window Right";
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
        key = "<leader>wm";
        action = "<cmd>XxvimToggleZoom<cr>";
        options.desc = "Toggle Zoom Mode";
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
        key = "[b";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options.desc = "Prev Buffer";
      }
      {
        mode = "n";
        key = "]b";
        action = "<cmd>BufferLineCycleNext<cr>";
        options.desc = "Next Buffer";
      }
      {
        mode = "n";
        key = "<leader>bb";
        action = "<cmd>XxvimOtherBuffer<cr>";
        options.desc = "Switch to Other Buffer";
      }
      {
        mode = "n";
        key = "<leader>`";
        action = "<cmd>XxvimOtherBuffer<cr>";
        options.desc = "Switch to Other Buffer";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<cr>";
        options.desc = "Delete Buffer";
      }
      {
        mode = "n";
        key = "<leader>bD";
        action = "<cmd>XxvimDeleteBufferAndWindow<cr>";
        options.desc = "Delete Buffer and Window";
      }
      {
        mode = "n";
        key = "<leader>bo";
        action = "<cmd>lua _G.xxvim_workflow.close_other_buffers()<cr>";
        options.desc = "Delete Other Buffers";
      }
      {
        mode = "n";
        key = "<leader><tab><tab>";
        action = "<cmd>tabnew<cr>";
        options.desc = "New Tab";
      }
      {
        mode = "n";
        key = "<leader><tab>]";
        action = "<cmd>tabnext<cr>";
        options.desc = "Next Tab";
      }
      {
        mode = "n";
        key = "<leader><tab>[";
        action = "<cmd>tabprevious<cr>";
        options.desc = "Previous Tab";
      }
      {
        mode = "n";
        key = "<leader><tab>f";
        action = "<cmd>tabfirst<cr>";
        options.desc = "First Tab";
      }
      {
        mode = "n";
        key = "<leader><tab>l";
        action = "<cmd>tablast<cr>";
        options.desc = "Last Tab";
      }
      {
        mode = "n";
        key = "<leader><tab>d";
        action = "<cmd>tabclose<cr>";
        options.desc = "Close Tab";
      }
      {
        mode = "n";
        key = "<leader><tab>o";
        action = "<cmd>tabonly<cr>";
        options.desc = "Close Other Tabs";
      }
      {
        mode = "n";
        key = "<leader>qs";
        action = "<cmd>XxvimSessionRestore<cr>";
        options.desc = "Restore Session";
      }
      {
        mode = "n";
        key = "<leader>qd";
        action = "<cmd>lua require('persistence').stop()<cr>";
        options.desc = "Don't Save Current Session";
      }
      {
        mode = "n";
        key = "<leader>qS";
        action = "<cmd>lua Snacks.picker.files({ cwd = vim.fn.stdpath('state') .. '/sessions' })<cr>";
        options.desc = "Select Session";
      }
      {
        mode = "n";
        key = "<leader>ql";
        action = "<cmd>XxvimSessionLoadLast<cr>";
        options.desc = "Restore Last Session";
      }
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>qa<cr>";
        options.desc = "Quit All";
      }
      {
        mode = "n";
        key = "<leader>sna";
        action = "<cmd>lua require('noice').cmd('all')<cr>";
        options.desc = "Noice All";
      }
      {
        mode = "n";
        key = "<leader>snd";
        action = "<cmd>lua require('noice').cmd('dismiss')<cr>";
        options.desc = "Dismiss All";
      }
      {
        mode = "n";
        key = "<leader>snh";
        action = "<cmd>lua require('noice').cmd('history')<cr>";
        options.desc = "Noice History";
      }
      {
        mode = "n";
        key = "<leader>snl";
        action = "<cmd>lua require('noice').cmd('last')<cr>";
        options.desc = "Noice Last Message";
      }
      {
        mode = "n";
        key = "<leader>n";
        action = "<cmd>lua Snacks.notifier.show_history()<cr>";
        options.desc = "Notification History";
      }
      {
        mode = "n";
        key = "<leader>pR";
        action = "<cmd>XxvimCdRoot<cr>";
        options.desc = "Cd Root";
      }
      {
        mode = "n";
        key = "<leader>rc";
        action = "<cmd>OverseerRun cargo check<cr>";
        options.desc = "Cargo Check";
      }
      {
        mode = "n";
        key = "<leader>rC";
        action = "<cmd>OverseerRun cargo clippy<cr>";
        options.desc = "Cargo Clippy";
      }
      {
        mode = "n";
        key = "<leader>rr";
        action = "<cmd>OverseerRun cargo run<cr>";
        options.desc = "Cargo Run";
      }
      {
        mode = "n";
        key = "<leader>rT";
        action = "<cmd>OverseerRun cargo nextest<cr>";
        options.desc = "Cargo Nextest";
      }
      {
        mode = "n";
        key = "<leader>rp";
        action = "<cmd>OverseerRun python current file<cr>";
        options.desc = "Python Run File";
      }
      {
        mode = "n";
        key = "<leader>rm";
        action = "<cmd>OverseerRun cmake build<cr>";
        options.desc = "CMake Build";
      }
    ];
  };
}

{ ... }:
{
  config.keymaps = [
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
  ];
}

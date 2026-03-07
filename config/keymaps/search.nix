{ ... }:
{
  config.keymaps = [
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
        action = "<cmd>lua Snacks.picker.grep({ cwd = require('xxvim.root').project_root() })<cr>";
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
        action = "<cmd>lua require('snacks').explorer.open({ cwd = require('xxvim.root').project_root() })<cr>";
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
        action = "<cmd>lua Snacks.picker.files({ cwd = require('xxvim.root').project_root() })<cr>";
        options.desc = "Find Files (Root Dir)";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>lua Snacks.picker.files({ cwd = require('xxvim.root').project_root() })<cr>";
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
        action = "<cmd>lua Snacks.picker.git_files({ cwd = require('xxvim.root').project_root() })<cr>";
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
  ];
}

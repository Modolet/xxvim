{ ... }:
{
  config.keymaps = [
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
}

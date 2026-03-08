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
        action = "<cmd>XxvimQuitAll<cr>";
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
        action = "<cmd>lua require('xxvim.tasks').check()<cr>";
        options.desc = "Project Check/Configure";
      }
      {
        mode = "n";
        key = "<leader>rC";
        action = "<cmd>lua require('xxvim.tasks').secondary()<cr>";
        options.desc = "Project Secondary Action";
      }
      {
        mode = "n";
        key = "<leader>rb";
        action = "<cmd>lua require('xxvim.tasks').build()<cr>";
        options.desc = "Project Build";
      }
      {
        mode = "n";
        key = "<leader>rr";
        action = "<cmd>lua require('xxvim.tasks').primary()<cr>";
        options.desc = "Project Run";
      }
      {
        mode = "n";
        key = "<leader>rt";
        action = "<cmd>lua require('xxvim.tasks').test()<cr>";
        options.desc = "Project Test";
      }
      {
        mode = "n";
        key = "<leader>rT";
        action = "<cmd>lua require('xxvim.tasks').extra_test()<cr>";
        options.desc = "Project Extra Test";
      }
      {
        mode = "n";
        key = "<leader>rd";
        action = "<cmd>lua require('xxvim.tasks').debug()<cr>";
        options.desc = "Project Debug";
      }
      {
        mode = "n";
        key = "<leader>rs";
        action = "<cmd>lua require('xxvim.tasks').select()<cr>";
        options.desc = "Project Select/Sync";
      }
      {
        mode = "n";
        key = "<leader>rR";
        action = "<cmd>lua require('xxvim.tasks').picker()<cr>";
        options.desc = "Project Task Picker";
      }
    ];
}

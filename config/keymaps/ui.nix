{ ... }:
{
  config.keymaps = [
      {
        mode = "n";
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
        options.desc = "Flash Jump";
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "S";
        action = "<cmd>lua require('flash').treesitter()<cr>";
        options.desc = "Flash Treesitter";
      }
      {
        mode = [
          "n"
          "o"
        ];
        key = "sr";
        action = "<cmd>lua require('flash').remote()<cr>";
        options.desc = "Flash Remote";
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "sR";
        action = "<cmd>lua require('flash').treesitter_search()<cr>";
        options.desc = "Flash Treesitter Search";
      }
      {
        mode = "n";
        key = "<leader>uf";
        action = "<cmd>lua require('xxvim.toggle').toggle_autoformat_global()<cr>";
        options.desc = "Toggle Auto Format (Global)";
      }
      {
        mode = "n";
        key = "<leader>uF";
        action = "<cmd>lua require('xxvim.toggle').toggle_autoformat_buffer()<cr>";
        options.desc = "Toggle Auto Format (Buffer)";
      }
      {
        mode = "n";
        key = "<leader>uh";
        action = "<cmd>lua require('xxvim.toggle').toggle_inlay_hints()<cr>";
        options.desc = "Toggle Inlay Hints";
      }
      {
        mode = "n";
        key = "<leader>ud";
        action = "<cmd>lua require('xxvim.toggle').toggle_diagnostics()<cr>";
        options.desc = "Toggle Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>ul";
        action = "<cmd>lua require('xxvim.toggle').toggle_option('number', true, false, 'wo')<cr>";
        options.desc = "Toggle Line Numbers";
      }
      {
        mode = "n";
        key = "<leader>uL";
        action = "<cmd>lua require('xxvim.toggle').toggle_option('relativenumber', true, false, 'wo')<cr>";
        options.desc = "Toggle Relative Number";
      }
      {
        mode = "n";
        key = "<leader>uw";
        action = "<cmd>lua require('xxvim.toggle').toggle_option('wrap', true, false, 'wo')<cr>";
        options.desc = "Toggle Wrap";
      }
      {
        mode = "n";
        key = "<leader>us";
        action = "<cmd>lua require('xxvim.toggle').toggle_option('spell', true, false, 'wo')<cr>";
        options.desc = "Toggle Spelling";
      }
      {
        mode = "n";
        key = "<leader>uc";
        action = "<cmd>lua require('xxvim.toggle').toggle_conceal()<cr>";
        options.desc = "Toggle Conceal Level";
      }
      {
        mode = "n";
        key = "<leader>uA";
        action = "<cmd>lua require('xxvim.toggle').toggle_tabline()<cr>";
        options.desc = "Toggle Tabline";
      }
      {
        mode = "n";
        key = "<leader>ub";
        action = "<cmd>lua require('xxvim.toggle').toggle_background()<cr>";
        options.desc = "Toggle Dark Background";
      }
      {
        mode = "n";
        key = "<leader>ug";
        action = "<cmd>lua require('xxvim.toggle').toggle_indent_guides()<cr>";
        options.desc = "Toggle Indent Guides";
      }
      {
        mode = "n";
        key = "<leader>uT";
        action = "<cmd>lua require('xxvim.toggle').toggle_treesitter_highlight()<cr>";
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
  ];
}

{ ... }:
{
  config.keymaps = [
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
        action = "<cmd>lua require('xxvim.buffers').close_other_buffers()<cr>";
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
  ];
}

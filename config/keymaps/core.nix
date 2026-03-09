{ ... }:
{
  config.keymaps = [
    {
      mode = [
        "n"
        "i"
        "x"
        "s"
      ];
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
      mode = [
        "n"
        "i"
        "s"
      ];
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
  ];
}

{ ... }:
{
  config = {
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;

    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
      clipboard = "unnamedplus";
      showmode = false;
      breakindent = true;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes";
      updatetime = 200;
      timeoutlen = 300;
      splitright = true;
      splitbelow = true;
      inccommand = "nosplit";
      cursorline = true;
      scrolloff = 4;
      sidescrolloff = 8;
      termguicolors = true;
      wrap = false;
      completeopt = "menu,menuone,noselect";
      expandtab = true;
      shiftwidth = 4;
      tabstop = 4;
      softtabstop = 4;
      laststatus = 3;
      smoothscroll = true;
    };

    globals = {
      loaded_perl_provider = 0;
      mapleader = " ";
    };

    extraConfigLuaPre = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = ","
      vim.g.xxvim_start_time = vim.uv.hrtime()

      pcall(function()
        require("xxvim.root").sync_startup_cwd()
      end)
    '';
  };
}

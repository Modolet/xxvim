{ pkgs, ... }:
{
  imports = [
    ./core.nix
    ./theme.nix
    ./ui.nix
    ./editor.nix
    ./coding.nix
    ./languages.nix
    ./dap.nix
    ./keymaps.nix
  ];

  config = {
    extraPlugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      alpha-nvim
      lualine-nvim
      bufferline-nvim
      gitsigns-nvim
      indent-blankline-nvim
      snacks-nvim
      blink-cmp
      friendly-snippets
      blink-compat
      luasnip
      yanky-nvim
      dial-nvim
      inc-rename-nvim
      noice-nvim
      nui-nvim
      nvim-notify
      which-key-nvim
      nvim-lspconfig
      nvim-treesitter-textobjects
      conform-nvim
      todo-comments-nvim
      flash-nvim
      plenary-nvim
      trouble-nvim
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-nio
    ];

    extraPackages = with pkgs; [
      neovim-remote
      fd
      ripgrep
      git
      gcc
      gdb
      lldb
      rust-analyzer
      cargo
      rustc
      clang-tools
      cmake
      cmake-language-server
      basedpyright
      ruff
      marksman
      gersemi
      python3
      python3Packages.debugpy
      nodePackages.vscode-langservers-extracted
      nodePackages.prettier
      nodePackages.markdownlint-cli
      nil
      nixfmt
      taplo
      shfmt
      stylua
    ];

    extraConfigLuaPre = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = ","
      vim.g.xxvim_start_time = vim.uv.hrtime()
    '';
  };
}

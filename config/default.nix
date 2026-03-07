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
      alpha-nvim
      blink-compat
      luasnip
      trouble-nvim
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

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
    ./tools.nix
    ./keymaps.nix
  ];

  config = {
    extraPlugins = with pkgs.vimPlugins; [
      alpha-nvim
      blink-compat
      luasnip
      trouble-nvim
      nvim-nio
      neotest
      neotest-python
      neotest-rust
      persistence-nvim
      crates-nvim
    ];

    extraPackages = with pkgs; [
      neovim-remote
      fd
      ripgrep
      git
      lazygit
      just
      gcc
      gdb
      lldb
      rust-analyzer
      cargo
      cargo-nextest
      clippy
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
      python3Packages.pytest
      nodePackages.vscode-langservers-extracted
      nodePackages.prettier
      nodePackages.markdownlint-cli
      nil
      nixfmt
      statix
      deadnix
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

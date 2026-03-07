{ pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      gcc
      gdb
      lldb
      clang-tools
      cmake
      cmake-language-server
    ];

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      c
      cmake
      cpp
    ];

    plugins.lsp.servers = {
      clangd.enable = true;
      cmake.enable = true;
    };
  };
}

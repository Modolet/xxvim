# @file assembly.nix
# @brief 汇编语言开发支持
# @author modolet <y@xxyx.io>
# @date 2026-09-03

{ pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      asm-lsp
      nasm
    ];

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      asm
      nasm
    ];

    plugins.lsp.servers.asm_lsp.enable = true;
  };
}

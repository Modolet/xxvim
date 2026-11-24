# @file assembly.nix
# @brief 汇编语言开发支持
# @author modolet <y@xxyx.io>
# @date 2026-09-03

{ config, pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      asm-lsp
      nasm
    ];

    plugins.treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      asm
      nasm
    ];

    plugins.lsp.servers.asm_lsp.enable = true;
  };
}

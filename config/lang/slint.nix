# @file slint.nix
# @brief Slint UI 语言开发支持
# @author modolet <y@xxyx.io>
# @date 2026-09-03

{ pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      slint-lsp
    ];

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      slint
    ];

    plugins.lsp.servers.slint_lsp.enable = true;

    extraConfigLuaPre = ''
      vim.filetype.add({
        extension = {
          slint = "slint",
        },
      })
    '';
  };
}

{ pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      doxygen
      marksman
      gersemi
      taplo
    ];

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      markdown
      markdown_inline
      toml
      vim
      vimdoc
    ];

    plugins.lsp.servers = {
      marksman.enable = true;
      taplo.enable = true;
    };
  };
}

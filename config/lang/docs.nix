{ config, pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      doxygen
      marksman
      gersemi
      taplo
    ];

    plugins.treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      markdown
      markdown_inline
      toml
      vim
      vimdoc
    ];

    plugins.render-markdown = {
      enable = true;
      settings = {
        preset = "lazy";
        enabled = true;
      };
    };

    plugins.lsp.servers = {
      marksman.enable = true;
      taplo.enable = true;
    };
  };
}

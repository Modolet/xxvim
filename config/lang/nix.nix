{ config, pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      deadnix
      nixd
      nixfmt
      statix
    ];

    plugins.treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      nix
      query
    ];

    plugins.lsp.servers.nixd = {
      enable = true;
      settings = {
        formatting.command = [ "nixfmt" ];
      };
    };
  };
}

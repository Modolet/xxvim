{ pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      deadnix
      nixd
      nixfmt
      statix
    ];

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
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

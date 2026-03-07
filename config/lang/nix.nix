{ pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      nil
      nixfmt
      statix
      deadnix
    ];

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
      query
    ];

    plugins.lsp.servers.nil_ls.enable = true;
  };
}

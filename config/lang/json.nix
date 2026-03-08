{ pkgs, ... }:
{
  config = {
    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      json
    ];

    plugins.lsp.servers.jsonls.enable = true;
  };
}

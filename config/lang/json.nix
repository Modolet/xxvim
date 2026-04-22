{ pkgs, ... }:
{
  config = {
    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [
      json
    ];

    plugins.lsp.servers.jsonls.enable = true;
  };
}

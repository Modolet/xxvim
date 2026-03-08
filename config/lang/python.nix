{ pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      basedpyright
      python3
      uv
      python3Packages.debugpy
      python3Packages.pytest
      ruff
    ];

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      python
    ];

    plugins.lsp.servers.basedpyright.enable = true;
  };
}

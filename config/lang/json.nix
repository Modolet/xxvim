{ config, ... }:
{
  config = {
    plugins.treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      json
    ];

    plugins.lsp.servers.jsonls.enable = true;
  };
}

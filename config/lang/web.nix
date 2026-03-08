{ pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      emmet-language-server
      nodePackages.prettier
      tailwindcss-language-server
      typescript
      typescript-language-server
      vue-language-server
    ];

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      css
      html
      javascript
      jsdoc
      tsx
      typescript
      vue
    ];

    plugins.lsp.servers = {
      cssls.enable = true;
      emmet_language_server.enable = true;
      html.enable = true;
      tailwindcss.enable = true;
      ts_ls.enable = true;
      vue_ls = {
        enable = true;
        tslsIntegration = true;
      };
    };
  };
}

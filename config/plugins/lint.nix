{ ... }:
{
  config.plugins.lint = {
    enable = true;
    lintersByFt = {
      python = [ "ruff" ];
      markdown = [ "markdownlint" ];
      json = [ "jsonlint" ];
      nix = [ "statix" ];
    };
    autoCmd = {
      event = [ "BufEnter" "BufWritePost" "InsertLeave" ];
      callback = {
        __raw = ''
          function()
            require("lint").try_lint()
          end
        '';
      };
    };
  };
}

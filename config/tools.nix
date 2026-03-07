{ ... }:
{
  config = {
    plugins.lint = {
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

    plugins.overseer = {
      enable = true;
      settings = {
        dap = true;
        strategy = "toggleterm";
        task_list = {
          direction = "right";
          min_width = 45;
          max_width = 70;
          default_detail = 1;
        };
      };
    };

    extraConfigLua = builtins.readFile ./lua/xxvim/tools.lua;
  };
}

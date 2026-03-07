{ ... }:
{
  config = {
    plugins.yanky = {
      enable = true;
      settings = {
        ring.history_length = 100;
        picker.select.action = null;
      };
    };

    plugins.comment.enable = true;
    plugins.sleuth.enable = true;
    plugins.dial.enable = true;
    plugins.inc-rename.enable = true;

    extraConfigLua = builtins.readFile ./lua/xxvim/workflow.lua;
  };
}

{ ... }:
{
  config = {
    plugins.yanky.enable = true;
    plugins.comment.enable = true;
    plugins.sleuth.enable = true;
    extraConfigLua = builtins.readFile ./lua/xxvim/editor.lua;
  };
}

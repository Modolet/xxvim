{ pkgs, ... }:
{
  config = {
    extraPlugins = with pkgs.vimPlugins; [ alpha-nvim ];
    extraConfigLua = builtins.readFile ../lua/xxvim/dashboard.lua;
  };
}

# @file multicursor.nix
# @brief 多光标插件配置
# @author modolet <y@xxyx.io>
# @date 2026-09-04

{ pkgs, ... }:
{
  config = {
    extraPlugins = [ pkgs.vimPlugins.multicursor-nvim ];

    extraConfigLua = ''
      require("xxvim.multicursor").setup()
    '';
  };
}

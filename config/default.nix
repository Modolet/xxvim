{ lib, ... }:
{
  imports = [
    ./core
    ./plugins
    ./lang
    ./keymaps
  ];

  options.xxvim.theme.stylix.enable = lib.mkEnableOption "use Stylix-managed colors instead of xxvim catppuccin defaults";
}

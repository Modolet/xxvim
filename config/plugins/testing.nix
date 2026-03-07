{ pkgs, ... }:
{
  config.extraPlugins = with pkgs.vimPlugins; [
    neotest
    neotest-python
    neotest-rust
    nvim-nio
    persistence-nvim
  ];
}

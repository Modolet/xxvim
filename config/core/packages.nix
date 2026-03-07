{ pkgs, ... }:
{
  config.extraPackages = with pkgs; [
    neovim-remote
    fd
    ripgrep
    git
    lazygit
    just
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier
    nodePackages.markdownlint-cli
    shfmt
    stylua
  ];
}

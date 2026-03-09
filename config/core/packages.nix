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
    ghostscript
    mermaid-cli
    shfmt
    sqlite
    stylua
    texliveSmall
  ];
}

{ pkgs, ... }:
{
  config.extraPackages = with pkgs; [
    neovim-remote
    fd
    ripgrep
    git
    lazygit
    just
    vscode-langservers-extracted
    prettier
    markdownlint-cli
    ghostscript
    mermaid-cli
    shfmt
    sqlite
    stylua
    texliveSmall
  ];
}

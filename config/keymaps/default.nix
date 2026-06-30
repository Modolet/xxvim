{ ... }:
{
  imports = [
    ./core.nix
    ./search.nix
    ./git.nix
    ./lsp.nix
    ./ui.nix
    ./debug_test_terminal.nix
    ./flutter.nix
    ./window_buffer_tab.nix
    ./session_run.nix
  ];
}

{ pkgs, ... }:
{
  config = {
    extraPlugins = with pkgs.vimPlugins; [ crates-nvim ];

    extraPackages = with pkgs; [
      cargo
      cargo-nextest
      clippy
      rust-analyzer
      rustc
      rustfmt
    ];

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      rust
    ];

    plugins.lsp.servers.rust_analyzer = {
      enable = true;
      installCargo = false;
      installRustc = false;
    };

    extraConfigLua = ''
      local ok_crates, crates = pcall(require, "crates")
      if ok_crates then
        crates.setup({
          popup = {
            border = "rounded",
          },
          completion = {
            blink = {
              use_custom_kind = true,
            },
          },
        })
      end
    '';
  };
}

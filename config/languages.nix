{ pkgs, ... }:
{
  config = {
    plugins.treesitter = {
      enable = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        c
        cmake
        cpp
        json
        lua
        markdown
        markdown_inline
        nix
        python
        query
        rust
        toml
        vim
        vimdoc
      ];
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };

    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          timeout_ms = 1000;
          lsp_format = "fallback";
        };
        formatters_by_ft = {
          c = [ "clang_format" ];
          cpp = [ "clang_format" ];
          cmake = [ "gersemi" ];
          json = [ "prettier" ];
          markdown = [ "prettier" ];
          nix = [ "nixfmt" ];
          python = [ "ruff_format" ];
          rust = [ "rustfmt" ];
          toml = [ "taplo" ];
        };
      };
    };

    plugins.lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        clangd.enable = true;
        cmake.enable = true;
        basedpyright.enable = true;
        jsonls.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        taplo.enable = true;
      };
    };

    autoCmd = [
      {
        event = [ "BufWritePre" ];
        pattern = [ "*.nix" "*.rs" "*.py" "*.c" "*.cpp" "*.json" "*.md" "*.toml" "CMakeLists.txt" "*.cmake" ];
        callback = {
          __raw = ''
            function()
              require("conform").format({ async = false, lsp_format = "fallback" })
            end
          '';
        };
      }
    ];

    extraConfigLua = builtins.readFile ./lua/xxvim/lsp.lua;
  };
}

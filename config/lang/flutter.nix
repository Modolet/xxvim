{ pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      dart
      flutter
    ];

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      dart
    ];

    plugins.conform-nvim.settings.formatters_by_ft.dart = [ "dart_format" ];

    plugins.flutter-tools = {
      enable = true;
      settings = {
        ui.border = "rounded";
        root_patterns = [
          ".git"
          "pubspec.yaml"
        ];
        widget_guides.enabled = true;
        closing_tags = {
          enabled = true;
          highlight = "Comment";
          prefix = "// ";
          priority = 10;
        };
        dev_log = {
          enabled = true;
          notify_errors = false;
        };
        dev_tools = {
          autostart = false;
          auto_open_browser = false;
        };
        outline.auto_open = false;
        lsp.color = {
          enabled = true;
          virtual_text = true;
        };
        debugger.enabled = false;
      };
    };

    autoCmd = [
      {
        event = [ "BufWritePre" ];
        pattern = [ "*.dart" ];
        callback = {
          __raw = ''
            function()
              if require("xxvim.toggle").state.autoformat == false then
                return
              end
              if vim.b.xxvim_autoformat == false then
                return
              end
              require("conform").format({ async = false, lsp_format = "fallback" })
            end
          '';
        };
      }
    ];

    extraConfigLua = ''
      vim.env.FLUTTER_SUPPRESS_ANALYTICS = vim.env.FLUTTER_SUPPRESS_ANALYTICS or "true"
      vim.env.DART_SUPPRESS_ANALYTICS = vim.env.DART_SUPPRESS_ANALYTICS or "true"
      vim.env.PUB_CACHE = vim.env.PUB_CACHE or (vim.fn.stdpath("data") .. "/dart/pub-cache")
      vim.fn.mkdir(vim.env.PUB_CACHE, "p")
    '';
  };
}

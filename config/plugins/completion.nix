{ pkgs, ... }:
{
  config = {
    extraPlugins = with pkgs.vimPlugins; [
      blink-compat
      copilot-lua
      luasnip
    ];

    plugins.blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "default";
          "<C-space>" = [ "show" "show_documentation" "hide_documentation" ];
          "<C-j>" = [ "select_next" "fallback" ];
          "<C-k>" = [ "select_prev" "fallback" ];
          "<CR>" = [ "accept" "fallback" ];
          "<Tab>" = [ "snippet_forward" "fallback" ];
          "<S-Tab>" = [ "snippet_backward" "fallback" ];
        };
        appearance = {
          use_nvim_cmp_as_default = true;
          nerd_font_variant = "mono";
        };
        completion = {
          ghost_text.enabled = true;
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
            window.border = "rounded";
            window.scrollbar = false;
          };
          menu = {
            border = "rounded";
            scrollbar = false;
            draw = {
              padding = 1;
              gap = 1;
              columns = [
                [ "kind_icon" ]
                [ "label" "label_description" ]
              ];
            };
          };
        };
        signature = {
          enabled = true;
          window.border = "rounded";
        };
        snippets.preset = "luasnip";
        sources.default = [ "lsp" "path" "snippets" "buffer" ];
      };
    };

    plugins.copilot-lua = {
      enable = true;
      settings = {
        panel.enabled = false;
        suggestion = {
          enabled = true;
          auto_trigger = true;
          hide_during_completion = true;
          keymap = {
            accept = "<M-l>";
            accept_word = false;
            accept_line = false;
            next = false;
            prev = false;
            dismiss = false;
          };
        };
      };
    };

    plugins.friendly-snippets.enable = true;
  };
}

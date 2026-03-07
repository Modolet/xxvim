{ pkgs, ... }:
{
  config = {
    extraPlugins = with pkgs.vimPlugins; [
      blink-compat
      luasnip
    ];

    plugins.blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "default";
          "<C-space>" = [ "show" "show_documentation" "hide_documentation" ];
          "<CR>" = [ "accept" "fallback" ];
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

    plugins.friendly-snippets.enable = true;
  };
}

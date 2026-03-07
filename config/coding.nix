{ ... }:
{
  config = {
    plugins.blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "default";
          "<C-space>" = [ "show" "show_documentation" "hide_documentation" ];
          "<CR>" = [ "accept" "fallback" ];
        };
        appearance = {
          use_nvim_cmp_as_default = false;
          nerd_font_variant = "mono";
        };
        completion = {
          documentation.auto_show = true;
          ghost_text.enabled = true;
        };
        signature.enabled = true;
        snippets.preset = "luasnip";
        sources.default = [ "lsp" "path" "snippets" "buffer" ];
      };
    };

    plugins.friendly-snippets.enable = true;

    extraConfigLua = builtins.readFile ./lua/xxvim/coding.lua;
  };
}

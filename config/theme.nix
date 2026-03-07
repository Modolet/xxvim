{ ... }:
{
  config = {
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        integrations = {
          blink_cmp = true;
          gitsigns = true;
          native_lsp.enabled = true;
          noice = true;
          notify = true;
          snacks = true;
          treesitter = true;
          which_key = true;
        };
      };
    };
  };
}

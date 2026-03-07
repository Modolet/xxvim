{ ... }:
{
  config = {
    plugins.web-devicons.enable = true;
    plugins.lualine.enable = true;
    plugins.bufferline.enable = true;
    plugins.which-key.enable = true;
    plugins.notify.enable = true;
    plugins.noice.enable = true;
    plugins.todo-comments.enable = true;
    plugins.flash.enable = true;
    plugins.gitsigns.enable = true;
    plugins.indent-blankline.enable = true;

    extraConfigLua = builtins.readFile ./lua/xxvim/ui.lua;
  };
}

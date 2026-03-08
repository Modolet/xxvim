{ ... }:
{
  config = {
    extraConfigLua = ''
      require("xxvim.workflow")
    '';

    plugins.yanky = {
      enable = true;
      settings = {
        ring.history_length = 100;
        picker.select.action = null;
      };
    };

    plugins.comment.enable = true;
    plugins.sleuth.enable = true;
    plugins.dial.enable = true;
    plugins.inc-rename = {
      enable = true;
      settings = {
        input_buffer_type = "snacks";
        hl_group = "Substitute";
        preview_empty_name = false;
        show_message = true;
        save_in_cmdline_history = false;
      };
    };

    plugins.nvim-autopairs = {
      enable = true;
      settings = {
        check_ts = true;
        disable_filetype = [ "TelescopePrompt" "snacks_picker_input" ];
      };
    };

    plugins.mini-surround.enable = true;
    plugins.mini-ai.enable = true;
  };
}

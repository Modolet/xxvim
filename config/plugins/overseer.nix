{ ... }:
{
  config = {
    plugins.overseer = {
    enable = true;
    settings = {
      dap = true;
      strategy = "toggleterm";
      task_list = {
        direction = "right";
        min_width = 45;
        max_width = 70;
        default_detail = 1;
      };
    };
    };

    extraConfigLua = ''
      require("xxvim.tools")
    '';
  };
}

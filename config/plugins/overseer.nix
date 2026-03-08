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

    plugins.cmake-tools = {
      enable = true;
      settings = {
        cmake_build_directory = "out/\${variant:buildType}";
        cmake_regenerate_on_save = true;
        cmake_soft_link_compile_commands = false;
        cmake_compile_commands_from_lsp = true;
        cmake_executor = {
          name = "overseer";
          opts = { };
        };
        cmake_runner = {
          name = "overseer";
          opts = { };
        };
      };
    };

    extraConfigLua = ''
      require("xxvim.tools")
    '';
  };
}

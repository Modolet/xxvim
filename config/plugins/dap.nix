{ ... }:
{
  config = {
    plugins.dap.enable = true;

    plugins.dap-ui = {
      enable = true;
      settings = {
        layouts = [
          {
            elements = [
              { id = "scopes"; size = 0.55; }
              { id = "breakpoints"; size = 0.15; }
              { id = "stacks"; size = 0.15; }
              { id = "watches"; size = 0.15; }
            ];
            size = 40;
            position = "left";
          }
          {
            elements = [
              { id = "repl"; size = 0.5; }
              { id = "console"; size = 0.5; }
            ];
            size = 10;
            position = "bottom";
          }
        ];
      };
    };

    plugins.dap-virtual-text = {
      enable = true;
      settings = {};
    };
  };
}

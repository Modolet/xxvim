{ ... }:
{
  config = {
    extraConfigLua = builtins.readFile ./lua/xxvim/dap.lua;
  };
}

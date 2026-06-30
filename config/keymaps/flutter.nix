{ ... }:
{
  config.keymaps = [
    {
      mode = "n";
      key = "<leader>Fr";
      action = "<cmd>FlutterRun<cr>";
      options.desc = "Flutter Run";
    }
    {
      mode = "n";
      key = "<leader>Fq";
      action = "<cmd>FlutterQuit<cr>";
      options.desc = "Flutter Quit";
    }
    {
      mode = "n";
      key = "<leader>Fh";
      action = "<cmd>FlutterReload<cr>";
      options.desc = "Flutter Hot Reload";
    }
    {
      mode = "n";
      key = "<leader>FR";
      action = "<cmd>FlutterRestart<cr>";
      options.desc = "Flutter Hot Restart";
    }
    {
      mode = "n";
      key = "<leader>Fd";
      action = "<cmd>FlutterDevices<cr>";
      options.desc = "Flutter Devices";
    }
    {
      mode = "n";
      key = "<leader>Fe";
      action = "<cmd>FlutterEmulators<cr>";
      options.desc = "Flutter Emulators";
    }
    {
      mode = "n";
      key = "<leader>Fo";
      action = "<cmd>FlutterOutlineToggle<cr>";
      options.desc = "Flutter Outline";
    }
    {
      mode = "n";
      key = "<leader>Fl";
      action = "<cmd>FlutterLogToggle<cr>";
      options.desc = "Flutter Log";
    }
    {
      mode = "n";
      key = "<leader>FD";
      action = "<cmd>FlutterDevTools<cr>";
      options.desc = "Flutter DevTools";
    }
    {
      mode = "n";
      key = "<leader>Fc";
      action = "<cmd>FlutterCopyProfilerUrl<cr>";
      options.desc = "Flutter Profiler URL";
    }
    {
      mode = "n";
      key = "<leader>Ft";
      action = "<cmd>XxvimBottomTerm flutter test<cr>";
      options.desc = "Flutter Test";
    }
    {
      mode = "n";
      key = "<leader>Fa";
      action = "<cmd>XxvimBottomTerm flutter analyze<cr>";
      options.desc = "Flutter Analyze";
    }
    {
      mode = "n";
      key = "<leader>Fp";
      action = "<cmd>XxvimBottomTerm flutter pub get<cr>";
      options.desc = "Flutter Pub Get";
    }
  ];
}

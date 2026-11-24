return {
  enabled = true,
  sections = { { section = "header" }, { section = "keys", gap = 1 } },
  preset = {
    header = table.concat({
      "          ██╗  ██╗██╗  ██╗██╗   ██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗          Z",
      "          ╚██╗██╔╝╚██╗██╔╝╚██╗ ██╔╝╚██╗██╔╝██║   ██║██║████╗ ████║      Z    ",
      "           ╚███╔╝  ╚███╔╝  ╚████╔╝  ╚███╔╝ ██║   ██║██║██╔████╔██║   z       ",
      "           ██╔██╗  ██╔██╗   ╚██╔╝   ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║ z         ",
      "          ██╔╝ ██╗██╔╝ ██╗   ██║   ██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║           ",
      "          ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝           ",
    }, "\n"),
    keys = {
      {
        key = "f",
        icon = " ",
        desc = "Find File",
        action = function()
          Snacks.picker.files({ cwd = require("xxvim.root").project_root() })
        end,
      },
      { key = "n", icon = " ", desc = "New File", action = ":ene" },
      { key = "p", icon = " ", desc = "Projects", action = ":XxvimRecentProjects" },
      {
        key = "g",
        icon = " ",
        desc = "Find Text",
        action = function()
          Snacks.picker.grep({ cwd = require("xxvim.root").project_root() })
        end,
      },
      {
        key = "r",
        icon = " ",
        desc = "Recent Files",
        action = function()
          Snacks.picker.recent()
        end,
      },
      { key = "q", icon = " ", desc = "Quit", action = ":XxvimQuitAll" },
    },
  },
}

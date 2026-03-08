let
  keymapGroups = builtins.fromJSON (builtins.readFile ../meta/keymap-groups.json);
  whichKeyGroupsLua = builtins.concatStringsSep "\n" (
    map (item: ''          { "${item.prefix}", group = "${item.group}" },'') keymapGroups
  );
in
{ ... }:
{
  config = {
    plugins.web-devicons.enable = true;

    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          theme = "catppuccin";
          globalstatus = true;
          section_separators = { left = ""; right = ""; };
          component_separators = { left = "│"; right = "│"; };
        };
      };
    };

    plugins.bufferline = {
      enable = true;
      settings = {
        options = {
          mode = "buffers";
          diagnostics = "nvim_lsp";
          always_show_bufferline = true;
          separator_style = "slant";
          offsets = [
            {
              filetype = "snacks_layout_box";
              text = "Explorer";
              separator = true;
            }
          ];
        };
      };
    };

    plugins.which-key = {
      enable = true;
      settings = {
        preset = "modern";
        delay = 200;
        icons.mappings = true;
      };
      luaConfig.post = ''
        require("which-key").add({
${whichKeyGroupsLua}
        })
      '';
    };

    plugins.notify = {
      enable = true;
      settings.timeout = 3000;
    };

    plugins.noice = {
      enable = true;
      settings = {
        presets.inc_rename = true;
        cmdline = {
          enabled = true;
          view = "cmdline_popup";
          format.cmdline = {
            icon = ">";
            lang = "vim";
            title = "";
          };
        };
        popupmenu.enabled = true;
        views.cmdline_popup = {
          position = {
            row = 2;
            col = "50%";
          };
          size = {
            width = 60;
            height = "auto";
          };
          border = {
            style = "rounded";
            padding = [ 0 1 ];
          };
          win_options.winhighlight = "Normal:Normal,FloatBorder:FloatBorder";
        };
      };
    };

    plugins.trouble = {
      enable = true;
      settings = {
        auto_close = false;
        auto_refresh = true;
        focus = false;
        follow = true;
        indent_guides = true;
        modes = {
          diagnostics = { auto_open = false; };
        };
        win = {
          position = "right";
          size = 0.25;
        };
      };
    };

    plugins.todo-comments.enable = true;
    plugins.flash.enable = true;

    plugins.gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        signs_staged_enable = true;
      };
    };

    plugins.indent-blankline = {
      enable = true;
      settings = {
        indent.char = "▏";
        scope.enabled = true;
      };
    };

    plugins.snacks = {
      enable = true;
      settings = {
        picker = {
          enabled = true;
          sources = {
            files.hidden = true;
            grep.hidden = true;
            explorer.hidden = true;
          };
          layout = {
            preset = "default";
            cycle = false;
          };
          matcher = {
            smartcase = true;
            frecency = true;
          };
          formatters.file.filename_first = true;
          win = {
            input.keys."<Esc>" = {
              __raw = ''{ "close", mode = { "n", "i" } }'';
            };
            preview.wo = {
              number = false;
              relativenumber = false;
            };
          };
        };
        explorer = {
          enabled = true;
          replace_netrw = true;
        };
        notifier = {
          enabled = true;
          timeout = 3000;
        };
        quickfile.enabled = true;
        indent.enabled = true;
        statuscolumn.enabled = true;
        words.enabled = true;
      };
    };
  };
}

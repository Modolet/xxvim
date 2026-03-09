let
  keymapGroups = builtins.fromJSON (builtins.readFile ../meta/keymap-groups.json);
  whichKeyGroupsLua = builtins.concatStringsSep "\n" (
    map (item: ''          { "${item.prefix}", group = "${item.group}" },'') keymapGroups
  );
in
{ lib, config, ... }:
let
  useStylix = config.xxvim.theme.stylix.enable;
in
{
  config = {
    plugins.web-devicons.enable = true;

    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          globalstatus = true;
          section_separators = { left = ""; right = ""; };
          component_separators = { left = "│"; right = "│"; };
        } // lib.optionalAttrs (!useStylix) {
          theme = "catppuccin";
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
          separator_style = "thin";
          show_buffer_close_icons = false;
          show_close_icon = false;
          enforce_regular_tabs = true;
          tab_size = 20;
          indicator.style = "none";
          offsets = [
            {
              filetype = "snacks_layout_box";
              text = "Explorer";
              separator = false;
              text_align = "left";
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
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = true;
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

    plugins.todo-comments = {
      enable = true;
    };

    plugins.flash = {
      enable = true;
      settings = {
        modes = {
          char.enabled = false;
          search.enabled = false;
        };
      };
    };

    plugins.gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        signs_staged_enable = true;
      };
    };

    extraConfigLua = ''
      local function apply_auxiliary_comment_highlights()
        local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
        if not comment or vim.tbl_isempty(comment) then
          return
        end

        local style = vim.tbl_extend("force", comment, {
          italic = true,
          bold = false,
        })

        vim.api.nvim_set_hl(0, "LspInlayHint", style)
        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", style)
      end

      local augroup = vim.api.nvim_create_augroup("xxvim_auxiliary_comment_highlights", { clear = true })

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = augroup,
        callback = apply_auxiliary_comment_highlights,
      })

      vim.api.nvim_create_autocmd("VimEnter", {
        group = augroup,
        once = true,
        callback = apply_auxiliary_comment_highlights,
      })
    '';

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
        scroll = {
          enabled = true;
          animate = {
            duration = {
              step = 10;
              total = 200;
            };
            easing = "linear";
          };
          animate_repeat = {
            delay = 100;
            duration = {
              step = 5;
              total = 50;
            };
            easing = "linear";
          };
        };
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

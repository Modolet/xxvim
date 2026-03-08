{ ... }:
{
  config = {
    plugins.grug-far = {
      enable = true;
      settings = {
        debounceMs = 300;
        minSearchChars = 1;
        maxSearchMatches = 2000;
        normalModeSearch = false;
        transient = true;
        headerMaxWidth = 80;
        engine = "ripgrep";
        engines.ripgrep = {
          path = "rg";
          showReplaceDiff = true;
        };
      };
    };

    extraConfigLua = ''
      require("xxvim.workflow")

      local function xxvim_search_replace()
        local root = require("xxvim.root").project_root()
        local grug_far = require("grug-far")

        if vim.fn.mode():match("[vV\22]") then
          grug_far.with_visual_selection({
            prefills = {
              paths = root,
            },
          })
          return
        end

        local word = vim.fn.expand("<cword>")
        grug_far.open({
          prefills = {
            search = word ~= "" and word or nil,
            paths = root,
          },
        })
      end

      vim.api.nvim_create_user_command("XxvimSearchReplace", xxvim_search_replace, { range = true })
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
    plugins.inc-rename.enable = true;

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

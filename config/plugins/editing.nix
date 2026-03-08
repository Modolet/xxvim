{ ... }:
{
  config = {
    plugins.nvim-ufo = {
      enable = true;
      settings = {
        close_fold_kinds_for_ft = {
          default = [ "imports" "comment" ];
          json = [ "array" ];
          markdown = [ ];
        };
        open_fold_hl_timeout = 0;
        preview = {
          mappings = {
            close = "q";
            scrollB = "<C-b>";
            scrollF = "<C-f>";
            scrollD = "<C-d>";
            scrollU = "<C-u>";
          };
          win_config = {
            border = "rounded";
            winblend = 0;
            maxheight = 20;
          };
        };
        provider_selector = ''
          function(_, filetype, buftype)
            if buftype == "nofile" then
              return "indent"
            end
            if filetype == "markdown" then
              return { "treesitter", "indent" }
            end
            return { "lsp", "indent" }
          end
        '';
      };
    };

    plugins.neogen = {
      enable = true;
      keymaps.generate = "<leader>cN";
      settings = {
        snippet_engine = "luasnip";
        languages = {
          c.template.annotation_convention = "doxygen";
          cpp.template.annotation_convention = "doxygen";
        };
      };
    };

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

      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

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

      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end, { desc = "Open All Folds" })

      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end, { desc = "Close All Folds" })
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

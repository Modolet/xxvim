{ pkgs, ... }:
{
  config = {
    plugins.treesitter = {
      enable = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        c
        cmake
        cpp
        json
        lua
        markdown
        markdown_inline
        nix
        python
        query
        rust
        toml
        vim
        vimdoc
      ];
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };

    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          timeout_ms = 1000;
          lsp_format = "fallback";
        };
        formatters_by_ft = {
          c = [ "clang_format" ];
          cpp = [ "clang_format" ];
          cmake = [ "gersemi" ];
          json = [ "prettier" ];
          markdown = [ "prettier" ];
          nix = [ "nixfmt" ];
          python = [ "ruff_format" ];
          rust = [ "rustfmt" ];
          toml = [ "taplo" ];
        };
      };
    };

    plugins.lsp = {
      enable = true;
      inlayHints = true;
      onAttach = ''
        local map = function(keys, func, desc, mode)
          vim.keymap.set(mode or "n", keys, func, { buffer = bufnr, desc = desc })
        end

        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("gr", vim.lsp.buf.references, "References")
        map("gI", vim.lsp.buf.implementation, "Goto Implementation")
        map("gt", vim.lsp.buf.type_definition, "Goto Type Definition")
        map("K", vim.lsp.buf.hover, "Hover")
        map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
        map("<leader>cr", vim.lsp.buf.rename, "Rename")
        map("<leader>cR", function() Snacks.picker.lsp_references() end, "References Picker")
        map("<leader>cf", function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end, "Format")
        map("<leader>sd", function() Snacks.picker.diagnostics_buffer() end, "Buffer Diagnostics")
        map("<leader>ss", function() Snacks.picker.lsp_symbols() end, "Document Symbols")
        map("<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, "Workspace Symbols")
      '';
      servers = {
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        clangd.enable = true;
        cmake.enable = true;
        basedpyright.enable = true;
        jsonls.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        taplo.enable = true;
      };
    };

    autoCmd = [
      {
        event = [ "BufWritePre" ];
        pattern = [ "*.nix" "*.rs" "*.py" "*.c" "*.cpp" "*.json" "*.md" "*.toml" "CMakeLists.txt" "*.cmake" ];
        callback = {
          __raw = ''
            function()
              require("conform").format({ async = false, lsp_format = "fallback" })
            end
          '';
        };
      }
    ];

    extraConfigLua = ''
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "if_many",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
          },
        },
      })
    '';
  };
}

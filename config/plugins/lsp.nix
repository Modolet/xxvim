{ config, ... }:
{
  config = {
    plugins.treesitter = {
      enable = true;
      grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
        bash
        regex
      ];
      highlight.enable = true;
      indent.enable = true;
    };

    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save.__raw = ''
          function(bufnr)
            if require("xxvim.toggle").state.autoformat and vim.b[bufnr].xxvim_autoformat ~= false then
              return { timeout_ms = 1000, lsp_format = "fallback" }
            end
          end
        '';
        formatters_by_ft = {
          c = [ "clang_format" ];
          cpp = [ "clang_format" ];
          cmake = [ "gersemi" ];
          css = [ "prettier" ];
          html = [ "prettier" ];
          javascript = [ "prettier" ];
          javascriptreact = [ "prettier" ];
          json = [ "prettier" ];
          markdown = [ "prettier" ];
          nix = [ "nixfmt" ];
          python = [ "ruff_format" ];
          rust = [ "rustfmt" ];
          scss = [ "prettier" ];
          typescript = [ "prettier" ];
          typescriptreact = [ "prettier" ];
          toml = [ "taplo" ];
          vue = [ "prettier" ];
        };
      };
    };

    plugins.lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        cssls.filetypes = [
          "css"
          "scss"
          "less"
        ];
        emmet_language_server.filetypes = [
          "css"
          "eruby"
          "html"
          "javascriptreact"
          "less"
          "sass"
          "scss"
          "svelte"
          "pug"
          "typescriptreact"
          "vue"
        ];
        html.filetypes = [
          "html"
          "templ"
        ];
        tailwindcss.filetypes = [
          "astro"
          "css"
          "html"
          "javascript"
          "javascriptreact"
          "markdown"
          "mdx"
          "scss"
          "svelte"
          "typescript"
          "typescriptreact"
          "vue"
        ];
        ts_ls.filetypes = [
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
        ];
        vue_ls.filetypes = [ "vue" ];
      };
      onAttach = ''
        local map = function(keys, func, desc, mode, opts)
          vim.keymap.set(
            mode or "n",
            keys,
            func,
            vim.tbl_extend("force", { buf = bufnr, desc = desc }, opts or {})
          )
        end

        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("gr", vim.lsp.buf.references, "References")
        map("gI", vim.lsp.buf.implementation, "Goto Implementation")
        map("gt", vim.lsp.buf.type_definition, "Goto Type Definition")
        map("K", vim.lsp.buf.hover, "Hover")
        map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
        map("<leader>cr", function()
          return ":" .. require("inc_rename").config.cmd_name .. " " .. vim.fn.expand("<cword>")
        end, "Rename", nil, { expr = true })
        map("<leader>cR", function() Snacks.picker.lsp_references() end, "References Picker")
        map("<leader>cf", function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end, "Format")
        map("<leader>sd", function() Snacks.picker.diagnostics_buffer() end, "Buffer Diagnostics")
        map("<leader>ss", function() Snacks.picker.lsp_symbols() end, "Document Symbols")
        map("<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, "Workspace Symbols")
      '';
    };

    extraConfigLua = ''
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      vim.diagnostic.config({
        jump = {
          on_jump = function(_, bufnr)
            vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
          end,
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
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

      vim.lsp.config("*", {
        capabilities = capabilities,
      })
    '';
  };
}

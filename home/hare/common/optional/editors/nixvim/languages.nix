{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.nixvim.lsp = {
    inlayHints.enable = true;
    keymaps = [
      {
        key = "<leader>cr";
        lspBufAction = "rename";
        options.desc = "Rename";
      }
      {
        key = "<leader>ca";
        lspBufAction = "code_action";
        options.desc = "Code Action";
      }
      {
        key = "<leader>gd";
        lspBufAction = "definition";
        options.desc = "Goto Definition";
      }
      {
        key = "<leader>gD";
        lspBufAction = "references";
        options.desc = "Goto References";
      }
      {
        key = "<leader>gI";
        lspBufAction = "implementation";
        options.desc = "Goto Implementation";
      }
      {
        key = "K";
        lspBufAction = "hover";
        options.desc = "Hover Documentation";
      }
      {
        key = "<C-k>";
        lspBufAction = "signature_help";
        options.desc = "Signature Documentation";
      }
      {
        key = "<leader>cx";
        action.__raw = "function() if vim.fn.getloclist(0, {winid=1}).winid ~= 0 then vim.cmd('lclose') else vim.diagnostic.setloclist() end end";
        options.desc = "Diagnostic List";
      }
      {
        key = "<leader>e";
        action = "vim.diagnostic.open_float";
        options.desc = "Floating Diagnostic Message";
      }
    ];
    servers = {
      "*" = {
        config = {
          capabilities = {
            textDocument = {
              semanticTokens = {
                multilineTokenSupport = true;
              };
            };
          };
          root_markers = [
            ".git"
          ];
        };
      };

      clangd = {
        enable = true;
        config = {
          cmd = [
            "clangd"
            "--background-index"
          ];
          filetypes = [
            "c"
            "cpp"
          ];
          root_markers = [
            "compile_commands.json"
            "compile_flags.txt"
          ];
        };
      };

      # nil_ls.enable = true;
      nixd = {
        enable = true;
        config = {
          formatting.command = [ "nixfmt" ];
          diagnostic.suppress = [ "sema-escaping-with" ];
          nixpkgs = {
            expr = ''import ${pkgs.path} {}'';
          };
          options = {
            nixos.expr = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").nixosConfigurations.configname.options'';
            home-manager.expr = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").nixosConfigurations.${config.hostSpec.hostName}.options.home-manager.users.type.getSubOptions []'';
          };
        };
      };

      tinymist = {
        enable = true;
        config = {
          formatterMode = "typstyle";
        };
      };

      texlab = {
        enable = true;
        config = {
        };
      };

      lua_ls = {
        enable = true;
        config = {
          Lua = {
            runtime = {
              version = "LuaJIT";
            };
            formatters = {
              ignoreComments = true;
            };
            signatureHelp = {
              enabled = true;
            };
            diagnostics = {
              globals = [
                "nixCats"
                "vim"
              ];
              disable = [ "missing-fields" ];
            };
            telemetry = {
              enabled = false;
            };
          };
        };
      };
      gopls.enable = false;
      ts_ls.enable = false;
      rust_analyzer.enable = false;
      bashls.enable = true;
      fish_lsp.enable = true;
      nushell.enable = true;
      ocamllsp.enable = false;
      pyright.enable = true;
      ruff.enable = true;
      cssls.enable = true;
      # jsonls.enable = true;
      # qmlls.enable = true;
      # marksman.enable = true;
      # markdown_oxide.enable = true;
      # hyprls.enable = true;
    };
  };
}

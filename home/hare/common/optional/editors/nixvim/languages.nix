{
  inputs,
  config,
  pkgs,
  ...
}:
{
  programs.nixvim.lsp = {
    inlayHints.enable = true;
    keymaps = [
      {
        key = "<leader>ca";
        lspBufAction = "code_action";
      }
    ];
    servers = {
      "*" = {
        settings = {
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
        settings = {
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
        settings = {
          formatting.command = [ "nixfmt" ];
          nixpkgs = {
            expr = ''import ${pkgs.path} {}'';
          };
          options = {
            nixos.expr = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").nixosConfigurations.configname.options'';
            home-manager.expr = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").nixosConfigurations.${config.hostSpec.hostName}.options.home-manager.users.type.getSubOptions []'';
          };
        };
      };

      tinymist.enable = true;
      lua_ls.enable = true;
      ts_ls.enable = true;
      rust_analyzer.enable = true;
      bashls.enable = true;
      ocamllsp.enable = true;
      pyright.enable = true;
    };
  };
}

{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      options = {
        tabstop = 2;
        shiftwidth = 2;
        showmode = false;
      };

      filetree.nvimTree = {
        enable = true;
        openOnSetup = false;
      };

      formatter.conform-nvim.enable = true;
      dashboard.dashboard-nvim.enable = true;

      mini = {
        statusline.enable = true;
        tabline.enable = true;
        pairs.enable = true;
        diff.enable = true;
        git.enable = true;
      };

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      ui.colorizer.enable = true;
      # tabline.nvimBufferline.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;

      languages = {
        enableDAP = true;
        enableFormat = true;
        enableLSP = true;
        enableTreesitter = true;

        nix = {
          enable = true;
          # format.type = "alejandra";
          lsp.server = "nixd";
          lsp.options = {
            nixos = {
              expr = "(builtins.getFlake \"github:Rsr45/nixos-config\").nixosConfigurations.apocrypha.options";
            };
            home-manager = {
              expr = "(builtins.getFlake \"github:Rsr45/nixos-config\").nixosConfigurations.apocrypha.options.home-manager.users.type.getSubOptions []";
            };
          };
        };

        clang.enable = true;
        csharp.enable = true;
        lua.enable = true;
        # nu.enable = true;
        # ts.enable = true;
        # rust.enable = true;
        # css.enable = true;
        # bash.enable = true;
        # markdown.enable = true;
        dart = {
          enable = true;
          flutter-tools.enable = true;
        };

        vala.enable = true;
        go.enable = true;
      };
    };
  };
}

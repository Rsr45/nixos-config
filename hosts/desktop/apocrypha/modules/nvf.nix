{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      theme = {
        enable = true;
        name = "rose-pine";
        style = "main";
      };

      options = {
        tabstop = 2;
        shiftwidth = 2;
      };

      filetree.nvimTree = {
        enable = true;
        openOnSetup = false;
      };

      formatter.conform-nvim.enable = true;
      dashboard.dashboard-nvim.enable = true;
      autopairs.nvim-autopairs.enable = true;
      # statusline.lualine.enable = false;
      mini = {
        statusline.enable = true;
        tabline.enable = true;
        pairs.enable = true;
        clue.enable = true;
        diff.enable = true;
        git.enable = true;
      };
      # tabline.nvimBufferline.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;

      languages = {
        enableDAP = true;
        enableExtraDiagnostics = true;
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

        # nu.enable = true;
        # ts.enable = true;
        # rust.enable = true;
        # css.enable = true;
        # bash.enable = true;
        # markdown.enable = true;
        # dart.lsp.enable = true;
        # lua.lsp.enable = true;
        # vala.lsp.enable = true;
      };
    };
  };
}

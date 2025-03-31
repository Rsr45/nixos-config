{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      luaConfigPre = ''
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr })
      '';

      options = {
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        showmode = false;
        relativenumber = false;
        cursorline = true;
      };

      diagnostics.nvim-lint.enable = true; # fixes lzn-auto-require can't find lint.lua

      filetree.nvimTree = {
        enable = true;
        openOnSetup = false;
      };

      formatter.conform-nvim.enable = true;
      dashboard.alpha.enable = true;

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      git.enable = true;
      autopairs.nvim-autopairs.enable = true;
      visuals.indent-blankline.enable = true;
      visuals.nvim-web-devicons.enable = true;

      ui = {
        colorizer = {
          enable = true;
          setupOpts.filetypes = {
            "*" = {};
          };
        };
      };

      mini.tabline.enable = true;
      telescope.enable = true;
      statusline.lualine = {
        enable = true;
        refresh = {
          statusline = 100;
          tabline = 100;
        };
      };

      autocomplete = {
        enableSharedCmpSources = true;
        blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
        };
      };

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

        clang.enable = true;
        lua.enable = true;
        nu.enable = true;
        ts.enable = true;
        rust.enable = true;
        css.enable = true;
        bash.enable = true;
        markdown.enable = true;
        # dart = {
        #   enable = true;
        #   flutter-tools.enable = true;
        # };

        vala.enable = true;
        go.enable = true;
      };
    };
  };
}

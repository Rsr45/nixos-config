{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf.enable = true;
  programs.nvf.settings.vim = {
    luaConfigPre = ''
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr })
    '';

    keymaps = [
      {
        key = "<Tab>";
        mode = "i";
        action = "<CMD>lua require(\"intellitab\").indent()<CR>";
      }
    ];

    undoFile.enable = true;
    useSystemClipboard = true;
    options = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      showmode = false;
      number = true;
      relativenumber = true;
      cursorline = true;
    };

    extraPlugins = {
      intellitab = {
        package = pkgs.vimPlugins.intellitab-nvim;
      };
    };

    terminal.toggleterm = {
      enable = true;
      lazygit.enable = true;
    };

    utility.yazi-nvim.enable = true;
    diagnostics.nvim-lint.enable = true; # fixes lzn-auto-require can't find lint.lua
    git.enable = true;
    autopairs.nvim-autopairs.enable = true;
    formatter.conform-nvim.enable = true;
    dashboard.dashboard-nvim.enable = true;
    filetree.nvimTree = {
      enable = true;
      openOnSetup = false;
    };

    binds = {
      whichKey = {
        enable = true;
        setupOpts = {
          preset = "helix";
        };
      };
      cheatsheet.enable = true;
    };

    visuals = {
      indent-blankline = {
        enable = true;
        setupOpts = {
          exclude = {
            buftypes = [
              "terminal"
              "quickfix"
            ];
            filetypes = [
              ""
              "checkhealth"
              "help"
              "lspinfo"
              "packer"
              "dashboard"
              "TelescopePrompt"
              "TelescopeResults"
              "yaml"
              "dashboard"
            ];
          };
          # indent = {};
        };
      };
      nvim-web-devicons.enable = true;
    };

    ui = {
      colorizer = {
        enable = true;
        setupOpts = {
          filetypes = {
            "*" = {};
          };
          user_default_options = {
            RGB = true;
            RRGGBB = true;
            names = true;
            RRGGBBAA = true;
            AARRGGBB = true;
            rgb_fn = true;
            hsl_fn = true;
            css = true;
            css_fn = true;
            # sass = true;
            virtualtext = "■";
            always_update = false;
          };
        };
      };
      borders = {
        enable = true;
        globalStyle = "solid";
      };
      breadcrumbs.enable = true;
    };

    utility.oil-nvim.enable = true;
    navigation.harpoon.enable = true;
    telescope.enable = true;
    statusline.lualine = {
      enable = true;
      refresh = {
        statusline = 100;
        tabline = 100;
        winbar = 100;
      };
    };

    autocomplete = {
      enableSharedCmpSources = true;
      blink-cmp = {
        enable = false;
        friendly-snippets.enable = true;
      };
      nvim-cmp.enable = true;
    };

    languages = {
      enableDAP = true;
      # enableExtraDiagnostics = true;
      enableFormat = true;
      enableLSP = true;
      enableTreesitter = true;

      nix = {
        enable = true;
        # format.type = "alejandra";
        lsp.server = "nil";
        lsp.options = {
          nixpkgs = {
            expr = "import (builtins.getFlake \"github:Rsr45/nixos-config\").inputs.nixpkgs { }";
          };
          nixos = {
            expr = "(builtins.getFlake \"github:Rsr45/nixos-config\").nixosConfigurations.apocrypha.options";
          };
          home-manager = {
            expr = "(builtins.getFlake \"github:Rsr45/nixos-config\").nixosConfigurations.apocrypha.options.home-manager.users.type.getSubOptions []";
          };
        };
      };

      bash.enable = true;
      clang.enable = true;
      css.enable = true;
      go.enable = true;
      lua.enable = true;
      markdown.enable = true;
      nu.enable = true;
      python.enable = true;
      rust.enable = true;
      ts.enable = true;
      typst.enable = true;
      vala.enable = true;
    };
  };
}

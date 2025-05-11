{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf.enable = true;
  programs.nvf.settings.vim = {
    keymaps = [
      {
        key = "<Tab>";
        mode = "i";
        action = "<CMD>lua require(\"intellitab\").indent()<CR>";
      }
    ];

    options = {
      autoindent = true;
      smartindent = true;
      softtabstop = 4;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      showmode = false;
      number = true;
      relativenumber = true;
      cursorline = true;
      cursorlineopt = "both";
      conceallevel = 1;
      tm = 100;
    };

    undoFile.enable = true;
    useSystemClipboard = true;

    extraPlugins = {
      intellitab = {
        package = pkgs.vimPlugins.intellitab-nvim;
      };
    };

    treesitter = {
      enable = true;
      indent.enable = true;
      highlight.additionalVimRegexHighlighting = true;
    };

    diagnostics = {
      enable = true;
      nvim-lint.enable = true;
      config = {
        virtual_text = false;
      };
    };

    terminal.toggleterm = {
      enable = true;
      lazygit.enable = true;
    };

    utility = {
      sleuth.enable = true;
      yazi-nvim.enable = true;
    };

    git.enable = true;
    autopairs.nvim-autopairs.enable = true;
    formatter.conform-nvim.enable = true;
    dashboard.dashboard-nvim.enable = true;

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
        enable = false;
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
        };
      };
      nvim-web-devicons.enable = true;
    };

    ui = {
      colorizer = {
        enable = true;
        setupOpts = {
          filetypes = {
            "*" = { };
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
        globalStyle = "single";
      };
      breadcrumbs.enable = true;
    };

    notes = {
      obsidian = {
        enable = true;
        setupOpts = {
          completion.nvim-cmp = true;
          workspaces = [
            {
              name = "Dev";
              path = "~/Personal/Vaults/Dev";
            }
          ];
        };
      };
    };
    # notes.orgmode.enable = true;
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
      activeSection = {
        a = [
          ''
            {
              "mode", fmt = function(str) return str:sub(1,1) end, color = nil,
            }
          ''
        ];
        b = [
          ''
            {
              "filename", color = nil, path = 1, file_status = true, newfile_status = true,

              symbols = {
                modified = '[+]',      -- Text to show when the file is modified.
                readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                unnamed = '[No Name]', -- Text to show for unnamed buffers.
                newfile = '[New]',     -- Text to show for newly created file before first write
              }
            }
          ''
        ];
        y = [
          ''
            {
              "branch", color = nil
            }
          ''
        ];
        z = [
          ''
            {
              'progress', 'location', color = nil
            }
          ''
        ];
      };
    };

    autocomplete = {
      enableSharedCmpSources = true;
      blink-cmp = {
        enable = false;
        friendly-snippets.enable = true;
        setupOpts = {
          cmdline.keymap.preset = "default";
          keymap.preset = "default";
        };
      };
      nvim-cmp.enable = true;
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      lspkind.enable = true;
      trouble.enable = true;
    };

    languages = {
      enableDAP = true;
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;

      nix = {
        enable = true;
        format.type = "nixfmt";
        lsp.server = "nixd";
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
      zig.enable = true;
    };
  };
}

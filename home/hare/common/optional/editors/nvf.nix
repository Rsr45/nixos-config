{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default
    ./navigation.nix
    ./lsp.nix
    ./languages.nix
  ];

  programs.nvf.enable = true;
  programs.nvf.settings.vim = {
    viAlias = false;
    vimAlias = false;
    keymaps = [
      # --------------- Plugin Binds ----------------------
      # {
      #   key = "<Tab>";
      #   mode = "i";
      #   action = "<CMD>lua require(\"intellitab\").indent()<CR>";
      # }
      # --------------- Movement -------------------------
      {
        key = "<S-Down>";
        mode = "v";
        action = ":m '>+1<CR>gv=gv";
        desc = "Moves Line Down";
      }
      {
        key = "<S-Up>";
        mode = "v";
        action = ":m '<-2<CR>gv=gv";
        desc = "Moves Line Up";
      }
      {
        key = "<C-d>";
        mode = "n";
        action = "<C-d>zz";
        desc = "Scroll Down";
      }
      {
        key = "<C-u>";
        mode = "n";
        action = "<C-u>zz";
        desc = "Scroll Up";
      }
      {
        key = "n";
        mode = "n";
        action = "nzzzv";
        desc = "Next Search Result";
      }
      {
        key = "N";
        mode = "n";
        action = "Nzzzv";
        desc = "Previous Search Result";
      }
      {
        key = "<Down>";
        mode = "n";
        action = "v:count == 0 ? 'gj' : 'j'";
        expr = true;
        silent = true;
      }
      {
        key = "<Up>";
        mode = "n";
        action = "v:count == 0 ? 'gk' : 'k'";
        expr = true;
        silent = true;
      }
      # ----------- Clipbord -----------------
      {
        key = "<leader>y";
        mode = [
          "n"
          "x"
          "v"
        ];
        action = "\"+y";
        noremap = true;
        silent = true;
        desc = "Yank to clipboard";
      }
      {
        key = "<leader>Y";
        mode = [
          "n"
          "x"
          "v"
        ];
        action = "\"+yy";
        noremap = true;
        silent = true;
        desc = "Yank line to clipboard";
      }
      {
        key = "<C-a>";
        mode = [
          "n"
          "x"
          "v"
        ];
        action = "gg0vG$";
        noremap = true;
        silent = true;
        desc = "Select All";
      }
      {
        key = "<leader>p";
        mode = [
          "n"
          "x"
          "v"
        ];
        action = "\"+p";
        noremap = true;
        silent = true;
        desc = "Paste from clipboard";
      }
      {
        key = "<C-p>";
        mode = "i";
        action = "<C-r><C-p>+";
        noremap = true;
        silent = true;
        desc = "Paste from clipboard within insert mode";
      }
      {
        key = "<leader>P";
        mode = "x";
        action = "\"_dP";
        noremap = true;
        silent = true;
        desc = "Paste over selection without erasing unnamed register";
      }
      ## ----- Obsidian -----
      # {
      #   key = "";
      #   mode = "";
      #   action = "";
      #   desc = "";
      # }
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
    # clipboard.registers = "unnamedplus";

    # extraPlugins = {
    # intellitab = {
    #   package = pkgs.vimPlugins.intellitab-nvim;
    # };
    # quick-scope = {
    #   package = pkgs.vimPlugins.quick-scope;
    # };
    # };

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
      # motion = {
      #   leap.enable = true;
      #
      # };
    };

    mini = {
      ai.enable = true;
      align.enable = true;
      bracketed.enable = true;
      # clue.enable = true;
      comment.enable = true;
      icons.enable = true;
      icons.setupOpts = {
        mock_nvim_web_devicons = true;
      };
      operators.enable = true;
      pairs.enable = true;
      surround = {
        enable = true;
        setupOpts = {
          mappings = {
            add = "gza"; # # Add surrounding in Normal and Visual modes
            delete = "gzd"; # # Delete surrounding
            find = "gzf"; # # Find surrounding (to the right)
            find_left = "gzF"; # # Find surrounding (to the left)
            highlight = "gzh"; # # Highlight surrounding
            replace = "gzr"; # # Replace surrounding
            update_n_lines = "gzn"; # # Update `n_lines`

            suffix_last = "l"; # # Suffix to search with "prev" method
            suffix_next = "n"; # # Suffix to search with "next" method
          };
        };
      };
    };
    # mini.statusline.enable = false;
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
    ui.noice.enable = true;
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
            ];
          };
        };
      };
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
      breadcrumbs.navbuddy.enable = true;
      smartcolumn.enable = true;
    };

    # languages.markdown.extensions.markview-nvim = {
    #   enable = true;
    #   setupOpts = {
    #     preview = {
    #       icon_provider = "mini";
    #     };
    #   };
    # };

    languages.markdown.extensions.render-markdown-nvim.enable = true;

    notes = {
      obsidian = {
        enable = true;
        setupOpts = {
          ui.enable = false;
          completion.blink = true;
          workspaces = [
            {
              name = "Personal";
              path = "~/Personal/Vaults/Personal";
              overrides = {
                notes_subdir = "05_Fleeting";
                attachments = {
                  img_folder = "99_Meta/01_Assets/imgs";
                };
              };
            }
            {
              name = "Work";
              path = "~/Personal/Vaults/Dev";
            }
          ];
          templates = {
            folder = "99_Meta/00_Templates";
            date_format = "%Y-%m-%d";
            time_format = "%H:%M";
            # -- A map for custom variables, the key should be the variable and the value a function.
            # -- Functions are called with obsidian.TemplateContext objects as their sole parameter.
            # -- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
            # -- substitutions = {},
            #
            # -- A map for configuring unique directories and paths for specific templates
            # --- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#customizations
            # -- customizations = {},
          };
          daily_notes = {
            # -- Optional; if you keep daily notes in a separate directory.
            folder = "06_Daily";
            # -- Optional; if you want to change the date format for the ID of daily notes.
            date_format = "%Y-%m-%d";
            # -- Optional; if you want to change the date format of the default alias of daily notes.
            alias_format = "%B %-d; %Y";
            # -- Optional; default tags to add to each new daily note created.
            # default_tags = { "daily-notes"};
            # -- Optional; if you want to automatically insert a template from your template directory like 'daily.md'
            # -- template = "daily.md";
            # -- Optional; if you want `Obsidian yesterday` to return the last work day or `Obsidian tomorrow` to return the next work day.
            workdays_only = true;
          };
        };
      };
      # orgmode = {
      #   enable = true;
      #   setupOpts = {
      #     org_agenda_files = [
      #       "~/Documents/org/*"
      #       "~/my-orgs/**/*"
      #     ];
      #     org_default_notes_file = "~/Documents/org/refile.org";
      #   };
      #   treesitter.enable = false;
      #   treesitter.orgPackage = pkgs.tree-sitter-grammars.tree-sitter-org-nvim;
      # };
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
      activeSection = {
        a = [
          ''
            {
              "mode", fmt = function(str) return str:sub(1,1) end, 
            }
          ''
        ];
        b = [
          ''
            {
              "filename",  path = 1, file_status = true, newfile_status = true,

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
              "branch",
            }
          ''
        ];
        z = [
          ''
            {
              'progress', 
            },
            {
              'location', 
            },
          ''
        ];
      };
    };

    autocomplete = {
      enableSharedCmpSources = true;
      blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
        setupOpts = {
          cmdline.keymap.preset = "default";
          keymap.preset = "default";
        };
      };
      nvim-cmp.enable = false;
    };
  };
}

{
  pkgs,
  inputs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hare";
  home.homeDirectory = "/home/hare";

  imports = [
    inputs.ags.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
    inputs.spicetify-nix.homeManagerModules.default
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  xdg.enable = true;
  xdg.userDirs.enable = true;

  # # Fixes Cursor
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  # # GTK Settings
  gtk = {
    enable = true;
    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Classic";
    theme.package = pkgs.kanagawa-gtk-theme;
    theme.name = "Kanagawa-BL";
    iconTheme.package = pkgs.kanagawa-icon-theme;
    iconTheme.name = "Kanagawa";
  };

  # # QT Settings
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };

  # # Hyprland Settings
  # class                 border  bground text    indicator child_border
  # client.focused          #fabd2f #1d2021 #fabd2f #83CAFA   #fabd2f
  # client.focused_inactive #8C8C8C #4C4C4C #FFFFFF #4C4C4C   #8C8C8C
  # client.unfocused        #4C4C4C #141617 #888888 #292D2E   #222222
  # client.urgent           #EC69A0 #DB3279 #FFFFFF #DB3279   #DB3279
  # client.placeholder      #000000 #0C0C0C #FFFFFF #000000   #0C0C0C
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      monitor = [",1920x1080@144,auto,1"];
      general = {
        gaps_in = 0;
        gaps_out = 0;
        # gaps_workspaces = 50;
        border_size = 4;
        layout = "dwindle";
        resize_on_border = true;
        # # Miasma.
        # "col.active_border" = "rgb(b36d43)";
        # "col.inactive_border" = "rgb(4c4c4c)";
        # # Gruvbox Hard.
        "col.active_border" = "rgb(fabd2f)";
        "col.inactive_border" = "rgb(4c4c4c)";
      };
      dwindle = {
        preserve_split = true;
        smart_resizing = false;
      };
      "exec-once" = [
        "ags -c /home/hare/.config/ags/simple-bar/config.js"
        # "eww daemon & eww open bar_1"
        "dunst"
        # "waybar -b verticalBar"
        "swww kill; swww-daemon"
      ];
      input = {
        # Keyboard: Add a layout and uncomment kb_options for Win+Space switching shortcut
        kb_layout = "tr";
        # kb_options = grp:win_space_toggle;
        numlock_by_default = true;
        repeat_delay = 250;
        repeat_rate = 35;
        accel_profile = "flat";

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
          scroll_factor = 0.5;
        };

        # special_fallthrough = true   # only in new hyprland versions. but they're hella fucked
        follow_mouse = 1;
      };
      decoration = {
        rounding = 0;

        blur = {
          enabled = true;
          xray = true;
          special = false;
          new_optimizations = true;
          size = 5;
          passes = 4;
          brightness = 1;
          noise = 1.0e-2;
          contrast = 1;
        };
        # Shadow
        drop_shadow = false;
        shadow_ignore_window = true;
        shadow_range = 20;
        shadow_offset = "0 2";
        shadow_render_power = 2;
        "col.shadow" = "rgba(0000001A)";

        # Dim
        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0;
      };
      animations = {
        enabled = true;
        bezier = [
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2.5, md3_decel"
          # "workspaces, 1, 3.5, md3_decel, slide"
          "workspaces, 1, 7, fluent_decel, slide"
          # "workspaces, 1, 7, fluent_decel, slidefade 15%"
          # "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };
      misc = {
        vfr = 1;
        vrr = 1;
        # layers_hog_mouse_focus = true
        focus_on_activate = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        enable_swallow = true;
        swallow_regex = "(foot|kitty|allacritty|Alacritty)";

        disable_hyprland_logo = true;
        new_window_takes_over_fullscreen = 2;
      };
      debug = {
        # overlay = true;
        # damage_tracking = 0;
        # damage_blink = true;
      };
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];
      bind = [
        # # # Window management
        # # Focusing
        # # bind = Super, ←/↑/→/↓,, # Move focus in direction
        "$mod, Left, movefocus, l"
        "$mod, Right, movefocus, r"
        "$mod, Up, movefocus, u"
        "$mod, Down, movefocus, d"
        "$mod+Shift, Q, killactive,"
        "$mod+Shift+Alt, Q, exec, hyprctl kill" # Pick and kill a window
        # # Window arrangement
        # # bind = Super+Shift, ←/↑/→/↓,, # Window: move in direction
        "$mod+Shift, Left, movewindow, l"
        "$mod+Shift, Right, movewindow, r"
        "$mod+Shift, Up, movewindow, u"
        "$mod+Shift, Down, movewindow, d"
        # # Positioning mode
        "$mod+Alt, Space, togglefloating,"
        "$mod+Alt, F, fullscreenstate, 0 3" # Toggle fake fullscreen
        "$mod, F, fullscreen, 0"
        "$mod, D, fullscreen, 1"
        # # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        # # Special Workspaces
        "$mod, S, togglespecialworkspace, magic"
        "$mod ALT, S, movetoworkspace, special:magic"
        # # # Actions
        # # Screenshot, Color Picker
        ", Print, exec, grim"
        "$mod SHIFT, S, exec, slurp | grim -g - $(date +'Screenshot_%F-%T.png')"
        "$mod SHIFT, C, exec, hyprpicker -a -f hex"
        # # Wallpaper
        "$mod+Alt, W, exec, pkill waypaper || waypaper"
        # # App Launcer
        "$mod, Space, exec, pkill fuzzel || fuzzel"
        # # Terminal
        "$mod, Return, exec, alacritty"
        # # File Explorer
        "$mod, T, exec, thunar"
        # # Power Off etc.
        "Ctrl+Shift+Super, Delete, exec, systemctl reboot" # Restart
        "Ctrl+Shift+Alt+Super, Delete, exec, systemctl poweroff || loginctl poweroff" # Power off
      ];
      windowrulev2 = [
        "float, class:(waypaper)"
      ];
    };
    extraConfig = ''
      # # Resizing(like i3)
      bind = $mod, R, submap,resize
      submap = resize
      binde=,Right,resizeactive,  40 0
      binde=,Left,resizeactive, -40 0
      binde=,Up,resizeactive,   0 -40
      binde=,Down,resizeactive,   0 40
      bind = ,escape, submap, reset
      bind = ,return,  submap, reset
      submap = reset
    '';
    plugins = with pkgs.hyprlandPlugins; [
      # borders-plus-plus
      csgo-vulkan-fix
    ];
  };

  # # Aylur's Gtk Shell.
  programs.ags = {
    enable = true;
    configDir = ./config-dir/ags-conf-dir;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  # # Elkowars Wacky Widgets.
  programs.eww = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    configDir = ./config-dir/eww-config-dir;
  };

  # # Waybar.
  xdg.configFile."waybar" = {
    source = ./config-dir/waybar-conf-dir;
    recursive = true;
  };
  programs.waybar = {
    enable = true;
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      colors = {
        background = "161616ff";
        text = "FFFFFFFF";
        prompt = "FFFFFFFF";
        input = "FFFFFFFF";
        match = "be95ffff";
        selection-match = "be95ffff";
        selection = "FFFFFFFF";
        selection-text = "161616FF";
        border = "FFFFFFFF";
      };
      border = {
        radius = "0";
        width = "4";
      };
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAbbrs = {
      rebuild = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake .#apocrypha";
      reboot = "systemctl reboot";
      shutdown = "systemctl poweroff";
      logout = "hyprctl dispatch exit 1";
      yt-mp3 = "yt-dlp --add-metadata -x --audio-quality 0 --audio-format mp3";
      yt-mp4 = "yt-dlp -f mp4";
      cs2-1080 = "gamescope -w 1080 -h 1080 -r 144 -S stretch --force-grab-cursor steam";
    };
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      # Manually packaging and enable a plugin
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion = {
      enable = true;
    };
    history = {
      append = true;
      share = true;
      extended = true;
      ignoreSpace = true;
      ignoreAllDups = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };
    shellAliases = {
      ls = "eza -a";
      ll = "eza -al";
      lt = "eza -a --tree --level=1";
      # cd = "z";
      yt-mp3 = "yt-dlp --add-metadata -x --audio-quality 0 --audio-format mp3";
      yt-mp4 = "yt-dlp -f mp4";
      reboot = "systemctl reboot";
      shutdown = "systemctl poweroff";
      yamltotoml = "find . -type f -name '*.yaml' | xargs -I {} alacritty migrate -c {}";
      ymltotoml = "find . -type f -name '*.yml' | xargs -I {} alacritty migrate -c {}";
    };
    antidote = {
      enable = true;
      plugins = [
        "getantidote/use-omz"
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-completions"
        "zsh-users/zsh-history-substring-search"
        "MichaelAquilina/zsh-auto-notify"
      ];
    };
    oh-my-zsh = {
      enable = true;
      theme = "bureau";
      plugins = [
        "git"
        "sudo"
      ];
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    package = pkgs.zoxide;
    options = [
    ];
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    extraOptions = [
      "--group-directories-first"
    ];
    icons = true;
  };

  programs.git = {
    enable = true;
    userName = "Rsr45";
    userEmail = "efe45676@gmail.com";
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "macos2";
        padding = {
          right = 2;
        };
      };
      # display = {
      # size = {
      # binaryPrefix = "si";
      # };
      # color = "blue";
      # separator = "  ";
      # };
      modules = [
        "Title"
        "Separator"
        "OS"
        "Kernel"
        "Bios"
        "Bootmgr"
        "Separator"
        "DE"
        "WM"
        "Terminal"
        "Shell"
        "Editor"
        "Font"
        "Separator"
        "Board"
        "CPU"
        "GPU"
        "Display"
        "Monitor"
        "Separator"
        "DateTime"
        "Uptime"
        "player"
        "media"
        "Colors"
      ];
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      import = [./themes/alacritty/miasma.toml];
      font = {
        size = 12;
      };
    };
  };

  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    extraConfig = ''
      -- Pull in the wezterm API
      local wezterm = require 'wezterm'

      -- This will hold the configuration.
      local config = wezterm.config_builder()

      -- This is where you actually apply your config choices
      config.enable_wayland = false
      config.front_end = "WebGpu"

      -- and finally, return the configuration to wezterm
      return config
    '';
  };

  programs.nixvim = {
    enable = true;
    colorschemes = {
      gruvbox.enable = false;
      oxocarbon.enable = false;
    };
    extraPlugins = with pkgs.vimPlugins; [
      miasma-nvim
    ];
    plugins = {
      lualine = {
        enable = true;
        settings = {
          options = {
            disabled_filetypes = {
              __unkeyed-1 = "startify";
              __unkeyed-2 = "neo-tree";
              statusline = [
                "dap-repl"
              ];
              winbar = [
                "aerial"
                "dap-repl"
                "neotest-summary"
              ];
            };
            globalstatus = true;
          };
          sections = {
            lualine_a = [
              "mode"
            ];
            lualine_b = [
              "branch"
            ];
            lualine_c = [
              "filename"
              "diff"
            ];
            lualine_x = [
              "diagnostics"
              {
                __unkeyed-1 = {
                  __raw = ''
                    function()
                        local msg = ""
                        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                        local clients = vim.lsp.get_active_clients()
                        if next(clients) == nil then
                            return msg
                        end
                        for _, client in ipairs(clients) do
                            local filetypes = client.config.filetypes
                            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                return client.name
                            end
                        end
                        return msg
                    end
                  '';
                };
                icon = "";
              }
              "encoding"
              "fileformat"
              "filetype"
            ];
            lualine_y = [
              {
                __unkeyed-1 = "aerial";
                colored = true;
                cond = {
                  __raw = ''
                    function()
                      local buf_size_limit = 1024 * 1024
                      if vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0)) > buf_size_limit then
                        return false
                      end

                      return true
                    end
                  '';
                };
                dense = false;
                dense_sep = ".";
                depth = {
                  __raw = "nil";
                };
                sep = " ) ";
              }
            ];
            lualine_z = [
              {
                __unkeyed-1 = "location";
              }
            ];
          };
          tabline = {
            lualine_a = [
              {
                __unkeyed-1 = "buffers";
                symbols = {
                  alternate_file = "";
                };
              }
            ];
            lualine_z = [
              "tabs"
            ];
          };
          winbar = {
            lualine_c = [
              {
                __unkeyed-1 = "navic";
              }
            ];
            lualine_x = [
              {
                __unkeyed-1 = "filename";
                newfile_status = true;
                path = 3;
                shorting_target = 150;
              }
            ];
          };
        };
      };
      notify = {
        enable = true;
      };
      nix.enable = true;
      numbertoggle.enable = true;
      nvim-tree = {
        enable = true;
      };
      which-key = {
        enable = true;
      };
      intellitab = {
        enable = true;
        # package = pkgs.vimPlugins.intellitab-nvim;
      };
      comment = {
        enable = true;
      };
      lsp = {
        enable = true;
        servers = {
          # # Nix
          # nil-ls.enable = true;
          nixd = {
            enable = true;
            settings = {
              nixpkgs = {
                expr = "import (builtins.getFlake \"/home/hare/nixos-config\").inputs.nixpkgs { }   ";
              };
              options = {
                nixos.expr = "(builtins.getFlake \"/home/hare/nixos-config\").nixosConfigurations.apocrypha.options";
                home-manager.expr = "(builtins.getFlake \"/home/hare/nixos-config\").homeConfigurations.apocrypha.options";
              };
            };
          };
          # # Lua
          lua-ls.enable = true;
          # # TypeScript
          ts-ls.enable = true;
        };
      };
      treesitter = {
        enable = true;
        nixvimInjections = true;
      };
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lua.enable = true;
      cmp-path.enable = true;
      cmp-treesitter.enable = true;
      cmp_luasnip.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            {name = "buffer";}
            {name = "luasnip";}
            {name = "nvim_lsp";}
            {name = "nvim_lua";}
            {name = "path";}
            {name = "treesitter";}
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          snippet = {
            expand = ''
              function(args)
              require('luasnip').lsp_expand(args.body)
              end
            '';
          };
        };
      };
      nvim-colorizer = {
        enable = true;
        userDefaultOptions = {
          mode = "background";
        };
      };
      telescope = {
        enable = true;
        extensions = {
          fzf-native = {
            enable = true;
          };
        };
      };
      dashboard = {
        enable = true;
        settings = {
          theme = "doom";
          config = {
            header = [
              "                                                                              "
              "=================     ===============     ===============   ========  ========"
              "\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //"
              "||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||"
              "|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||"
              "||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||"
              "|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||"
              "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||"
              "|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||"
              "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||"
              "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||"
              "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||"
              "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||"
              "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||"
              "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||"
              "||   .=='    _-'          `-__\\._-'         `-_./__-'         `' |. /|  |   ||"
              "||.=='    _-'                                                     `' |  /==.||"
              "=='    _-'                        N E O V I M                         \\/   `=="
              "\\   _-'                                                                `-_   /"
              " `''                                                                      ``'  "
            ];
            center = [
              {
                action = "Telescope oldfiles";
                desc = "Recently Opened Files";
                icon = "󱪞 ";
                key = "r";
                key_format = "%s";
              }
              {
                action = "Telescope find_files";
                desc = "Find Files           ";
                icon = " ";
                key = "f";
                key_format = "%s";
              }
              {
                action = "Telescope live_grep";
                desc = "Find Words           ";
                icon = " ";
                key = "w";
                key_format = "%s";
              }
            ];
          };
        };
      };
    };
    extraConfigLuaPre = ''
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '
      vim.opt.background = "dark"
      vim.cmd.colorscheme 'miasma'
    '';
    extraConfigLua = ''
      -- Make line numbers default1
      vim.opt.number = true
      vim.opt.relativenumber = true

      -- Enable mouse mode.
      vim.opt.mouse = 'a'

      -- Don't show the mode.
      vim.opt.showmode = false

      -- Enable break indent
      vim.opt.breakindent = true

      -- Save undo history
      vim.opt.undofile = true

      -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
      vim.opt.ignorecase = true
      vim.opt.smartcase = true

      -- Keep signcolumn on by default
      vim.opt.signcolumn = 'yes'

      -- Decrease update time
      vim.opt.updatetime = 250

      -- Decrease mapped sequence wait time
      -- Displays which-key popup sooner
      vim.opt.timeoutlen = 300

      -- Configure how new splits should be opened
      vim.opt.splitright = true
      vim.opt.splitbelow = true

      -- Sets how neovim will display certain whitespace characters in the editor.
      --  See `:help 'list'`
      --  and `:help 'listchars'`
      vim.opt.list = true
      vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

      -- Preview substitutions live, as you type!
      vim.opt.inccommand = 'split'

      -- Show which line your cursor is on
      vim.opt.cursorline = true

      -- Minimal number of screen lines to keep above and below the cursor.
      vim.opt.scrolloff = 10

      -- [[ Basic Keymaps ]]
      --  See `:help vim.keymap.set()`

      -- Clear highlights on search when pressing <Esc> in normal mode
      --  See `:help hlsearch`
      vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

      -- Diagnostic keymaps
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

      -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
      -- or just use <C-\><C-n> to exit terminal mode
      vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

      -- Keybinds to make split navigation easier.
      --  Use CTRL+<←↓↑→> to switch between windows
      --
      --  See `:help wincmd` for a list of all window commands
      vim.keymap.set('n', '<C-left>', '<C-w><C-left>', { desc = 'Move focus to the left window' })
      vim.keymap.set('n', '<C-right>', '<C-w><C-right>', { desc = 'Move focus to the right window' })
      vim.keymap.set('n', '<C-down>', '<C-w><C-down>', { desc = 'Move focus to the lower window' })
      vim.keymap.set('n', '<C-up>', '<C-w><C-up>', { desc = 'Move focus to the upper window' })
    '';
    extraConfigLuaPost = ''
    '';
  };

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    theme = spicePkgs.themes.text;
    #colorScheme = "mocha";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Fonts
    cascadia-code
    font-awesome
    geist-font
    ibm-plex
    inter
    iosevka
    roboto
    rubik
    (nerdfonts.override {
      fonts = [
        "FantasqueSansMono"
        "IBMPlexMono"
        "Iosevka"
        "IosevkaTerm"
        "IosevkaTermSlab"
      ];
    })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["BlexMonoNerdFont"];
      sansSerif = ["IBMPlexSans"];
      serif = ["IBMPlexSerif"];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/fangyuan/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

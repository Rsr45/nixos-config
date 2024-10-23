{ pkgs, inputs, ... }:

{
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
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      monitor = [ ",1920x1080@144,auto,1" ];
      general = {
        gaps_in = 4;
        gaps_out = 5;
        gaps_workspaces = 50;
        border_size = 4;
        layout = "dwindle";
        resize_on_border = true;
        "col.active_border" = "rgba(FFFFFFFF)";
        "col.inactive_border" = "rgba(131313FF)";
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
      # # Resizing with submap (like i3)
      bind = $mod, R, submap,resize
      submap = resize
      binde=,Right,resizeactive,  40 0
      binde=,Left,resizeactive, -40 0
      binde=,Up,resizeactive,   0 -40
      binde=,Down,resizeactive,   0 40
      bind = ,escape, submap, reset
      bind = ,return,  submap, reset
      submap = reset
      # #
      # plugin {
        # hyprbars {
          #  bar_text_font = Rubik, Geist, AR One Sans, Reddit Sans, Inter, Roboto, Ubuntu, Noto Sans, sans-serif
          #  bar_height = 30
          #  bar_padding = 10
          #  bar_button_padding = 5
          #  bar_precedence_over_border = false
          #  bar_part_of_window = true

          #  bar_color = rgba(161616FF)
          #  col.text = rgba(FFFFFFFF)


          #  # example buttons (R -> L)
          #  # hyprbars-button = color, size, on-click
          #  hyprbars-button = rgb(FF605C), 16, 󰖭, hyprctl dispatch killactive
          #  hyprbars-button = rgb(00CA4E), 16, 󰖯, hyprctl dispatch fullscreen 1
          #  hyprbars-button = rgb(FFBD44), 16, 󰖰, hyprctl dispatch movetoworkspacesilent special
        # }
      # }
    '';
    plugins = with pkgs.hyprlandPlugins; [
      # hyprbars
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

  # # Waybar Configuration.
  xdg.configFile."waybar" = {
    source = ./config-dir/waybar-conf-dir;
    recursive = true;
  };
  programs.waybar = {
    enable = true;
    settings = {
      verticalBar = {
        name = "verticalBar";
        layer = "top";
        position = "left";
        #margin = "5 2 5 0";
        #reload_style_on_change = "true";
        modules-left = [
          "custom/nixos"
          "hyprland/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "disk" "memory" "cpu" "tray" ];
        fixed-center = "true";
        "custom/nixos" = {
          format = "";
          tooltip = false;
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          all-outputs = true;
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };
          #format-icons = {
          #"1" = "१";
          #"2" = "२";
          #"3" = "३";
          #"4" = "४";
          #"5" = "५";
          #"6" = "६";
          #"7" = "७";
          #"8" = "८";
          #"9" = "९";
          #"10" = "०";
          #};
        };
        "clock" = {
          interval = 1;
          format = "{:%H\n%M\n%S}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              "today" = "<span color='#3ddbd9'><b><u>{}</u></b></span>";
            };
          };
        };
      };
    };
    style = ''
      /*Colors*/
      @define-color bg #222222;
      @define-color fg #c2c2b0;
      .verticalBar {
        border: none;
        font-family: "IBMPlexMono";
        font-size: 14px;
        background: @bg;
      }

      window.verticalBar#waybar {
       color: @fg;
      }

      .modules-left,
      .modules-center,
      .modules-right {
        background: @bg;
      }

      menu,
      tooltip {
        color: @fg;
        background-color: @bg;
        border: none;
        border-radius: 0;
      }

      menu label,
      tooltip label {
        font-size: 14px;
        color: @fg;
        border: none;
        border-radius: 0;
      }

      #custom-nixos,
      #workspaces,
      #clock,
      #pulseaudio,
      #disk,
      #memory,
      #cpu {
        padding: 0px 2px 0px 2px;
      }

      #custom-nixos {
        font-size: 34px;
      }

      #clock.verticalBar {
        color: @fg;
      }

      #workspaces.verticalBar button {
        color: @fg;
        background: none;
      }

      #workspaces.verticalBar button:hover {
        color: #ee5396;
        background: none;
      }

      window#waybar {
        color: #ffffff;
      }

      #pulseaudio.muted {
        color: #ee5396;
      }
    '';
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
      cd = "z";
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
        source = "nixos_small";
        padding = {
          right = 1;
        };
      };
      display = {
        size = {
          binaryPrefix = "si";
        };
        color = "blue";
          separator = "  ";
      };
      modules = [
        "OS"
        "DE"
        "WM"
        "CPU"
        "GPU"
        {
          type = "datetime";
          key = "Date";
          format = "{1}-{3}-{11}";
        }
        {
          type = "datetime";
          key = "Time";
          format = "{14}:{17}:{20}";
        }
          "break"
          "player"
          "media"
      ];
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      import = [ ./themes/alacritty/oxocarbon-dark.toml ];
    };
  };

  programs.nixvim = {
    enable = true;
    colorschemes = {
      gruvbox.enable = false;
      oxocarbon.enable = true;
    };
    plugins = {
      lualine = {
        enable = true;
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
          nil-ls.enable = true;
          # # Lua
          lua-ls.enable = true;
          # # TypeScript
          ts-ls.enable = true;
        };
      };
      treesitter = {
        enable = true;
        nixvimInjections = true;
        # grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          # bash
          # css
          # fennel
          # json
          # lua
          # make
          # markdown
          # nix
          # regex
          # toml
          # vim
          # vimdoc
          # xml
          # yaml
          # yuck
          # typescript
          # javascript
        # ];
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
            { name = "buffer"; }
            { name = "luasnip"; }
            { name = "nvim_lsp"; }
            { name = "nvim_lua"; }
            { name = "path"; }
            { name = "treesitter"; }
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

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
      {
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
      monospace = [ "BlexMonoNerdFont" ];
      sansSerif = [ "IBMPlexSans" ];
      serif = [ "IBMPlexSerif" ];
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
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

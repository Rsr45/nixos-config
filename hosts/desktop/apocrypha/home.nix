{ pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hare";
  home.homeDirectory = "/home/hare";

  imports = [
    inputs.ags.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
  ];

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
        # "ags"
        "eww daemon & eww open bar_1"
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
      bind = [
        # # Apps
        "$mod, i, exec, floorp"
        "$mod, Return, exec, alacritty"
        "$mod, t, exec, thunar"
        "$mod, End, exec, grim"
        # # Window management
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
        # # Special
        "$mod, S, togglespecialworkspace,"
        "$mod, mouse:275, togglespecialworkspace,"
        # # Wallpaper
        "$mod+Alt, W, exec, /home/hare/nixos-config/hosts/desktop/apocrypha/wallpaper_changer.sh"
        # # Power Off etc.
        "Ctrl+Shift+Super, Delete, exec, systemctl reboot" # Restart
        "Ctrl+Shift+Alt+Super, Delete, exec, systemctl poweroff || loginctl poweroff" # Power off
      ]
      ++ (
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
        9)
      );
    };
    extraConfig = ''
      # # Resizing with submap    
      bind = $mod, R, submap,resize    
      submap = resize    
      binde=,Right,resizeactive,  40 0    
      binde=,Left,resizeactive, -40 0    
      binde=,Down,resizeactive,   0 -40    
      binde=,Up,resizeactive,   0 40    
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

  programs.ags = {
    enable = true;
    configDir = null;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  programs.eww = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    configDir = "/home/hare/nixos-config/hosts/desktop/apocrypha/config-dir/eww-config-dir/";
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
      import = [ "/home/hare/nixos-config/hosts/desktop/apocrypha/themes/alacritty/kanagawa_wave.toml" ];
    };
  };

  programs.nixvim = {
    enable = true;
    colorschemes.oxocarbon.enable = true;
    plugins = {
      lualine.enable = true;
      neoscroll.enable = true;
      nix.enable = true;
      numbertoggle.enable = true;
      nvim-tree.enable = true;
      which-key.enable = true;
      lsp = {
        enable = true;
        servers = {
          # # Nix
          nil-ls.enable = true;
          # # Lua
          lua-ls.enable = true;
        };
      };
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          css
          fennel
          json
          lua
          make
          markdown
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
          yuck
        ];
      };      
      cmp = {
        enable = true;
        autoEnableSources = false;
        settings = {
          mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
              })
            '';
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
    extraConfigLua = ''
      -- Make line numbers default
      vim.opt.number = true
      vim.opt.relativenumber = true

      -- Enable mouse mode.
      vim.opt.mouse = 'a'

      -- Don't show the mode.
      vim.opt.showmode = false
    '';
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
    geist-font
    inter
    roboto
    rubik
    font-awesome
    (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

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
      monospace = [ "FiraCodeNerdFontMono-Regular" ];
      sansSerif = [ "FiraCodeNerdFont-Regular" ];
      serif = [ "FiraCodeNerdFont-Regular" ];
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

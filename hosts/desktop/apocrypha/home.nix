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
    ./modules/hyprland.nix
    ./modules/nvf.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  xdg.enable = true;
  xdg.userDirs.enable = true;

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  # # Fixes Cursor
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
    size = 32;
  };

  # # GTK Settings
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Gruvbox)";
    };
    theme = {
      name = "Gruvbox-Yellow-Dark-Compact-Medium";
      package = pkgs.gruvbox-gtk-theme.override {
        colorVariants = ["dark"];
        sizeVariants = ["compact"];
        themeVariants = ["yellow"];
        tweakVariants = ["medium"];
        iconVariants = ["Dark"];
      };
    };
    iconTheme = {
      package = pkgs.gruvbox-plus-icons;
      name = "Gruvbox-Plus-Dark";
    };
    font = {
      name = "IBM Plex Serif";
    };
  };

  # # QT Settings
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
  xdg.configFile = {
    "Kvantum/Gruvbox-Dark-Brown".source = "${pkgs.gruvbox-kvantum}/share/Kvantum/Gruvbox-Dark-Brown";
    "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=Gruvbox-Dark-Brown";
  };

  # # Aylur's Gtk Shell.
  programs.ags = {
    enable = true;
    configDir = ./config-dir/ags-conf-dir;
    extraPackages = with pkgs; [
      inputs.ags.packages.${pkgs.system}.apps
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.mpris
      inputs.ags.packages.${pkgs.system}.wireplumber
      inputs.ags.packages.${pkgs.system}.tray
      inputs.ags.packages.${pkgs.system}.notifd
      inputs.ags.packages.${pkgs.system}.network
      inputs.ags.packages.${pkgs.system}.battery
      fzf
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
        background = "282828ff";
        text = "FBF1C7ff";
        prompt = "FBF1C7ff";
        input = "FBF1C7ff";
        match = "FABD2Fff";
        selection-match = "FABD2Fff";
        selection = "3C3836ff";
        selection-text = "FBF1C7ff";
        border = "3C3836FF";
      };
      border = {
        radius = "12";
        width = "4";
      };
    };
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        frame_color = "#3C3836";
        font = "IBM Plex Serif";
        corner_radius = "12";
        gap_size = "8";
      };

      urgency_normal = {
        background = "#282828";
        foreground = "#FBF1C7";
        timeout = 10;
      };
    };
  };

  programs.nushell = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake .#apocrypha";
      reboot = "systemctl reboot";
      shutdown = "systemctl poweroff";
      logout = "hyprctl dispatch exit 1";
      yt-mp3 = "yt-dlp --add-metadata -x --audio-quality 0 --audio-format mp3";
      yt-mp4 = "yt-dlp -f mp4";
      cs2-1080 = "gamescope -w 1080 -h 1080 -r 144 -S stretch --force-grab-cursor steam";
    };
  };

  # programs.fish = {
  #   enable = true;
  #   interactiveShellInit = ''
  #     set fish_greeting # Disable greeting
  #   '';
  #   shellAbbrs = {
  #     rebuild = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake .#apocrypha";
  #     reboot = "systemctl reboot";
  #     shutdown = "systemctl poweroff";
  #     logout = "hyprctl dispatch exit 1";
  #     yt-mp3 = "yt-dlp --add-metadata -x --audio-quality 0 --audio-format mp3";
  #     yt-mp4 = "yt-dlp -f mp4";
  #     cs2-1080 = "gamescope -w 1080 -h 1080 -r 144 -S stretch --force-grab-cursor steam";
  #   };
  #   plugins = [
  #     # Enable a plugin (here grc for colorized command output) from nixpkgs
  #     {
  #       name = "grc";
  #       src = pkgs.fishPlugins.grc.src;
  #     }
  #     # Manually packaging and enable a plugin
  #     {
  #       name = "z";
  #       src = pkgs.fetchFromGitHub {
  #         owner = "jethrokuan";
  #         repo = "z";
  #         rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
  #         sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
  #       };
  #     }
  #   ];
  # };

  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = true;
  #   autocd = true;
  #   autosuggestion = {
  #     enable = true;
  #   };
  #   history = {
  #     append = true;
  #     share = true;
  #     extended = true;
  #     ignoreSpace = true;
  #     ignoreAllDups = true;
  #     ignoreDups = true;
  #     expireDuplicatesFirst = true;
  #   };
  #   shellAliases = {
  #     ls = "eza -a";
  #     ll = "eza -al";
  #     lt = "eza -a --tree --level=1";
  #     rebuild = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake .#apocrypha";
  #     yt-mp3 = "yt-dlp --add-metadata -x --audio-quality 0 --audio-format mp3";
  #     yt-mp4 = "yt-dlp -f mp4";
  #     reboot = "systemctl reboot";
  #     shutdown = "systemctl poweroff";
  #     logout = "hyprctl dispatch exit 1";
  #     yamltotoml = "find . -type f -name '*.yaml' | xargs -I {} alacritty migrate -c {}";
  #     ymltotoml = "find . -type f -name '*.yml' | xargs -I {} alacritty migrate -c {}";
  #     cs2-1080 = "gamescope -w 1080 -h 1080 -r 144 -S stretch --force-grab-cursor steam";
  #   };
  #   antidote = {
  #     enable = true;
  #     plugins = [
  #       "getantidote/use-omz"
  #       "zsh-users/zsh-syntax-highlighting"
  #       "zsh-users/zsh-autosuggestions"
  #       "zsh-users/zsh-completions"
  #       "zsh-users/zsh-history-substring-search"
  #       "MichaelAquilina/zsh-auto-notify"
  #     ];
  #   };
  #   oh-my-zsh = {
  #     enable = true;
  #     theme = "bureau";
  #     plugins = [
  #       "git"
  #       "sudo"
  #     ];
  #   };
  # };

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
    icons = "auto";
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
        # source = "macos2";
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
      general = {
        import = [./themes/alacritty/pastel_dark.toml];
      };
      font = {
        size = 12;
        # normal = [
        #   family = "BlexMonoNerdFont";
        #   style = "Regular";
        # ];
      };
    };
  };

  programs.kitty = {
    enable = true;
    themeFile = "gruvbox-dark";
    font = {
      name = "BlexMono Nerd Font";
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

      -- Colorschemes
      config.color_scheme = 'Gruvbox dark, hard (base16)'

      -- and finally, return the configuration to wezterm
      return config
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
    theme = spicePkgs.themes.comfy;
    colorScheme = "mono";
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
    font-awesome
    ibm-plex
    nerd-fonts.symbols-only
    nerd-fonts.blex-mono

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
      monospace = ["BlexMono Nerd Font"];
      sansSerif = ["IBM Plex Sans"];
      serif = ["IBM Plex Serif"];
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

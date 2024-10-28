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
    ./modules/nixvim.nix
    ./modules/i3wm.nix
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
    theme.package = pkgs.gruvbox-gtk-theme;
    theme.name = "Gruvbox-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "Papirus-Dark";
  };

  # # QT Settings
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
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
    QT_QPA_PLATFORMTHEME = "qt5ct";
    # EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

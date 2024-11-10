{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  # # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  networking = {
    hostName = "apocrypha"; # Define hostname
    networkmanager = {
      enable = true;
      # dns = "systemd-resolved";
      # insertNameservers = ["9.9.9.9" "1.1.1.1"];
    };
    # nameservers = ["9.9.9.9" "1.1.1.1"];
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,internal.domain";
    # };
  };

  time = {
    timeZone = "Europe/Istanbul";
  };

  # # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "tr_TR.UTF-8";
      LC_IDENTIFICATION = "tr_TR.UTF-8";
      LC_MEASUREMENT = "tr_TR.UTF-8";
      LC_MONETARY = "tr_TR.UTF-8";
      LC_NAME = "tr_TR.UTF-8";
      LC_NUMERIC = "tr_TR.UTF-8";
      LC_PAPER = "tr_TR.UTF-8";
      LC_TELEPHONE = "tr_TR.UTF-8";
      LC_TIME = "tr_TR.UTF-8";
    };
  };

  # # Configure console keymap.
  console = {
    keyMap = "trq";
  };

  # # Drivers, Keyboard Layout, CUPS Service.
  services = {
    xserver = {
      enable = true;
      autorun = true;
      videoDrivers = ["amdgpu"];
      xkb = {
        layout = "tr";
        variant = "";
      };
    };
    printing = {
      enable = true;
    };
  };

  # # OpenGL, 32Bit.
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    xone = { # support for the xbox controller USB dongle
      enable = true;
    };
  };

  # # Shell.
  programs = {
    bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
    fish = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
  };

  # # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
      hare = {
        isNormalUser = true;
        description = "Hare";
        extraGroups = [
          "networkmanager"
          "wheel"
          "libvirtd"
          "adbusers"
        ];
        # shell = pkgs.zsh;
      };
    };
  };

  # # Home Manager.
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    backupFileExtension = "backup1";
    users = {
      hare = import ./home.nix;
    };
  };

  programs.adb.enable = true;

  # # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # # Flakes, Garbage Collector, nixd.
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
    optimise = {
      automatic = true;
    };
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };

  # # i3 Window Manager
  services.xserver.windowManager.i3.enable = true;

  # # Display Manager
  services.displayManager = {
    sddm.enable = true;
    # lightdm.enable = true;
  };

  # # Sway Window Manager
  programs.sway = {
    enable = true;
    # package = pkgs.swayfx;
  };

  # # Hyprland Window Manager
  programs.hyprland = {
    enable = true;
  };
  # # Hint Electron apps to use Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
  # # Enable Kitty Terminal [DEPRECATED]
  # programs.kitty.enable = true;

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # # Polkit
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # # File Explorer
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
  };

  # # Audio
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      # jack.enable = true;

      # media-session.enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      # #
      home-manager # Home Manager
      polkit # Polkit
      polkit_gnome # Polkit Agent
      # # Basic Utils
      binutils
      coreutils
      desktop-file-utils
      diffutils
      fd
      file
      findutils
      fzf
      gawk
      git
      gnugrep
      gnumake
      gnused
      gnutar
      less
      procps
      ripgrep
      sharutils
      stow
      toybox
      util-linux
      xdg-utils
      xz
      # # Archive Managers and Compression
      p7zip
      peazip # Manager
      rar
      unrar
      unzip
      xarchiver # Manager
      zip
      # # File Explorer
      lf
      pcmanfm
      ranger
      superfile
      # # Terminal
      alacritty
      kitty
      wezterm
      # waveterm
      # # VSCode
      vscodium
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions;
          [
            bbenoist.nix
            ms-python.python
            ms-azuretools.vscode-docker
            ms-vscode-remote.remote-ssh
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "remote-ssh-edit";
              publisher = "ms-vscode-remote";
              version = "0.47.2";
              sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
            }
          ];
      })
      # # App Launchers and Widgets
      ags
      dmenu
      eww
      fuzzel
      tofi
      rofi
      wofi
      polybar
      swww
      waybar
      waypaper
      # # Utils
      yt-dlp
      thefuck
      ffmpeg
      ffmpegthumbnailer
      xclip
      wl-clipboard
      ps3iso-utils
      ps3-disc-dumper
      tldr
      playerctl
      dunst
      hyprgui
      notify
      libnotify
      pwvucontrol
      grim # Screenshot
      slurp # Screenshot
      hyprpicker # Color Picker
      socat
      jq
      python3
      discordchatexporter-cli
      nix-prefetch-github
      wallust
      # # Apps
      # blender
      upscayl # Image Upscaler
      vesktop # Discord Client
      teamspeak_client # Teamspeak Client
      teamspeak5_client # Teamspeak Client
      feh # Image Viewer
      mpv # Video Player
      mpvc # Video Player
      qbittorrent # Torrent Client
      logmein-hamachi # Hamachi
      haguichi # Hamachi Client
      anydesk # Remote Desktop Client
      localsend # File Sharing
      matugen # Material Color Generator
      obsidian # Note
      keepassxc # Password Manager
      smassh # Typing Test
      typioca # Typing Test
      mapscii # Map in Terminal
      spotify # Spotify Client
      ungoogled-chromium # Browser
      librewolf # Browser
      floorp # Browser
      firefox # Browser
      tor-browser # Browser
      palemoon-bin # Browser
      # ladybird # Browser
      opera # Browser
      thunderbird # Mail Client
      motrix # Download Manager
      qmmp # Music Player Winamp look alike
      libreoffice-qt6
      hunspell
      hunspellDicts.tr_TR
      hunspellDicts.en_US
      jdk # Java
      jdk17 # Java 17
      jdk8 # Java 8
      gitkraken # Git Client
      neovide # Neovim GUI
      lunarvim # Neovim Distrubition
      fastfetch # System Information Tool
      btop # Resource Monitoring
      grc # Fish Shell Dependency
      # # Language Server, Libraries, Compilers
      glib
      glibc
      libgcc
      gcc
      zig
      clang
      go
      nil
      nixd
      alejandra
      # # Wine
      wineWowPackages.staging
      winetricks
      protontricks
      # # Launchers and some utils
      heroic
      lutris
      mangohud # Fps Counter.
      nexusmods-app-unfree
      prismlauncher
      # # Emulation
      duckstation # PSX
      pcsx2 # PS2
      rpcs3 # PS3
      shadps4 # PS4
      (retroarch.override {
        cores = with libretro; [
          genesis-plus-gx
          snes9x # SNES
          beetle-psx-hw # PSX
          ppsspp # PSP
          flycast # Dreamcast
          picodrive
        ];
      })
      # # Games
      gzdoom # DOOM Source Port.
      chocolate-doom # DOOM Source Port.
      crispy-doom # DOOM Source Port.
      woof-doom # DOOM Source Port.
      dsda-doom # DOOM Source Port.
      dsda-launcher # DSDA-DOOM Launcher.
      eternity # DOOM Source Port.
    ];
  };

  # # Steam
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      remotePlay = {
        openFirewall = true; # Open ports in the firewall for Steam Remote Play
      };
      dedicatedServer = {
        openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      };
      localNetworkGameTransfers = {
        openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
      gamescopeSession = {
        enable = true;
        args = ["-r 144" "-S stretch"];
      };
    };
    gamemode = {
      enable = true;
    };
  };

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    # (nerdfonts.override { fonts = [  ]; })
    noto-fonts
    noto-fonts-emoji
    liberation_ttf
  ];

  # stylix.enable = true;
  # stylix.autoEnable = true;
  # stylix.polarity = "dark";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
  # stylix.image = ./wallhaven-d6y12l_3840x2160.png;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05";
}

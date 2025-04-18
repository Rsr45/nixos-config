{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../.././modules/default.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # # Bootloader
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

  # # Network
  networking = {
    hostName = "apocrypha"; # Define hostname
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      insertNameservers = [
        "9.9.9.9"
        "1.1.1.1"
      ];
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

  # # Select internationalisation properties
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

  # # Configure console keymap
  console = {
    keyMap = "trq";
  };

  # # Drivers, Keyboard Layout, CUPS Service
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
      theme = "${import ../../.././lib/pkgs/sddm-elegant.nix { inherit pkgs; }}";
    };
    xserver = {
      enable = true;
      autorun = true;
      videoDrivers = [ "amdgpu" ];
      xkb = {
        layout = "tr";
        variant = "";
      };
    };
    printing = {
      enable = true;
    };
  };

  # # OpenGL, 32Bit
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      # extraPackages = with pkgs; [mesa libva libvdpau-va-gl vulkan-loader vulkan-validation-layers mesa.opencl];
    };
    # amdgpu.amdvlk = {
    #   enable = true;
    #   support32Bit.enable = true;
    # };
    xone = {
      enable = true;
    };
  };

  # #
  programs = {
    adb = {
      enable = true;
    };
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  # # Define a user account. Don't forget to set a password with ‘passwd’
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
          "mpd"
        ];
        shell = pkgs.nushell;
      };
    };
  };

  # # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users = {
      hare = import ./home.nix;
    };
  };

  # # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # # Flakes, Garbage Collector, Hard Link, nixd
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    optimise = {
      automatic = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # # Hyprland Window Manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.uwsm.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # # Polkit
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
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
  security.rtkit.enable = true;
  services = {
    pulseaudio = {
      enable = false;
    };
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
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ADW_DISABLE_PORTAL = "1";
    };
    variables = {
      RUSTICL_ENABLE = "radeonsi";
      ROC_ENABLE_PRE_VEGA = "1";
      DOTNET_CLI_TELEMETRY_OPTOUT = "1";
    };
    systemPackages = with pkgs; [
      home-manager
      polkit
      polkit_gnome
      # # Archive Managers and Compression
      p7zip
      rar
      zip
      unrar
      unzip
      xarchiver
      nemo
      alacritty
      kitty
      git-credential-keepassxc
      libsForQt5.qt5.qtgraphicaleffects # # Dependency for sddm theme(s).
      networkmanagerapplet
      filezilla
      # # Utils
      discordchatexporter-cli
      nix-prefetch-git
      exiftool
      fuseiso
      # # Apps
      blender
      # upscayl # Image Upscaler
      # vesktop # Discord Client
      teamspeak_client # Teamspeak Client
      # teamspeak5_client # Teamspeak Client
      feh # Image Viewer
      mpv # Video Player
      vlc # Video Player
      vlc-bittorrent
      qbittorrent # Torrent Client
      # logmein-hamachi # Hamachi
      # haguichi # Hamachi Client
      anydesk # Remote Desktop Client
      localsend # File Sharing
      # pywalfox-native
      obsidian # Note
      brave
      # ungoogled-chromium
      # floorp
      # inputs.zen-browser.packages."${system}".default
      tor-browser
      # fum
      amberol
      # miru
      element-desktop # Matrix Client
      # fluffychat # Matrix Client
      onlyoffice-desktopeditors
      # libreoffice-fresh
      hunspell
      hunspellDicts.tr_TR
      hunspellDicts.en_US
      jdk # Java
      jdk17 # Java 17
      jdk8 # Java 8
      # neovim
      neovide # Neovim GUI
      lunarvim # Neovim Distrubition
      # btop # Resource Monitoring
      # # Language Server, Libraries, Compilers
      glib
      glibc
      libgcc
      gcc
      ncurses
      zig
      clang
      rustc
      cargo
      # rust-analyzer
      # rustfmt
      # dotnet-sdk_8
      # dotnet-sdk_9
      go
      vala
      # alejandra
      # nixfmt-rfc-style
      nil
      nixd
      love
      # # Wine
      wineWowPackages.staging
      winetricks
      protontricks
      protonup-qt
      # # Launchers and some utils
      (heroic.override {
        extraPkgs = pkgs: [
          pkgs.gamescope
          pkgs.gamemode
        ];
      })
      gamemode
      gamescope
      mangohud
      prismlauncher
      steamcmd
      # # Emulation
      # ppsspp # PSP
      # duckstation # PSX
      # pcsx2 # PS2
      # rpcs3 # PS3
      # shadps4 # PS4
      # ryujinx # Switch
      # (retroarch.override {
      #   cores = with libretro; [
      #     genesis-plus-gx
      #     snes9x # SNES
      #     beetle-psx-hw # PSX
      #     ppsspp # PSP
      #     flycast # Dreamcast
      #     picodrive
      #   ];
      # })
      # # DOOM
      gzdoom # DOOM Source Port.
      # chocolate-doom # DOOM Source Port.
      # crispy-doom # DOOM Source Port.
      # woof-doom # DOOM Source Port.
      # dsda-doom # DOOM Source Port.
      # dsda-launcher # DSDA-DOOM Launcher.
      # eternity # DOOM Source Port.
    ];
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  fonts.fontDir.enable = true;
  fonts.enableDefaultPackages = true;
  # fonts.packages = with pkgs; [
  # ];

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

  system.stateVersion = "24.11";
}

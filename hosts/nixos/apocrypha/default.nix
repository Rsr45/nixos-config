#############################################################
#
#  Apocrypha - Main Desktop
#  NixOS running on Ryzen 7 2700X, RX Vega 56, 16 GB RAM
#
#############################################################

{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = lib.flatten [
    # ============ Hardware Configs ==========
    ./hardware-configuration.nix
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-gpu-amd
    # inputs.hardware.nixosModules.common-pc-ssd

    (map lib.custom.relativeToRoot [
      # ========== Required Configs ==========
      "hosts/common/core"

      # ========== Optional Configs ==========
      "hosts/common/optional/services/greetd.nix"
      "hosts/common/optional/services/searxng.nix"
      "hosts/common/optional/services/keyd.nix"
      "hosts/common/optional/audio.nix"
      "hosts/common/optional/sway.nix"
      # "hosts/common/optional/plymouth.nix"
      "hosts/common/optional/protonvpn.nix"
      "hosts/common/optional/firejail.nix"
    ])
    # ========== Apocrypha Specific ========
    ./stylix.nix
    ./shared.nix
    ./steam.nix
  ];

  # ========== Host Specification ==========

  hostSpec = {
    hostName = "apocrypha";
  };

  sops = {
    defaultSopsFile = "/home/hare/nixos-config/secrets.yaml";
    validateSopsFiles = false;
    age.keyFile = "/home/hare/.config/sops/age/keys.txt";

    secrets = {
      searx-secret = { };
      hare-password = { };
      # nextcloud-admin = {
      #   owner = "nextcloud";
      # };
    };
  };

  networking = {
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    networkmanager = {
      dns = "systemd-resolved";
      insertNameservers = [
        "9.9.9.9"
        "1.1.1.1"
      ];
    };
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
    };
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.initrd = {
    systemd.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services = {
    xserver = {
      enable = true;
      autorun = true;
      videoDrivers = [ "amdgpu" ];
      xkb = {
        layout = "us";
        # variant = "colemak_dh_wide_iso";
        extraLayouts = {
          mine = {
            description = "Turkish Q layout {swap i and ı, ESC and CAPS}";
            languages = [ "tur" ];
            symbolsFile = ./custom_tr.xkb;
          };
        };
      };
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = builtins.readFile ./xmonad.hs;
        ghcArgs = [
          "-hidir /tmp" # place interface files in /tmp, otherwise ghc tries to write them to the nix store
          "-odir /tmp" # place object files in /tmp, otherwise ghc tries to write them to the nix store
          "-i${inputs.xmonad-contexts}" # tell ghc to search in the respective nix store path for the module
        ];
        extraPackages = haskellPackages: [
          haskellPackages.xmonad-contrib
          haskellPackages.monad-logger
        ];
      };
    };
    clamav = {
      updater.enable = true;
      daemon.enable = false;
    };
    gvfs.enable = true;
    tumbler.enable = true;
    flatpak.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      # extraPackages = with pkgs; [mesa libva libvdpau-va-gl vulkan-loader vulkan-validation-layers mesa.opencl];
    };
    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
    xone = {
      enable = true;
    };
  };

  programs = {
    adb.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    bash.interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
    fish.enable = true;
    uwsm.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    niri.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  # should not be required as it is set in users/hare
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
        shell = lib.mkForce pkgs.nushell;
      };
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  security = {
    polkit.enable = true;
    soteria.enable = true;
  };

  # systemd.services.flatpak-repo = {
  #   wantedBy = [ "multi-user.target" ];
  #   path = [ pkgs.flatpak ];
  #   script = ''
  #     flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  #   '';
  # };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ADW_DISABLE_PORTAL = "1";
    };
    variables = {
      RUSTICL_ENABLE = "radeonsi";
      ROC_ENABLE_PRE_VEGA = "1";
      DOTNET_CLI_TELEMETRY_OPTOUT = "1";
      # GTK_IM_MODULE = "ibus";
      # QT_IM_MODULE = "ibus";
      # XMODIFIERS = "@im=ibus";
      # MANPAGER = "bat";
      # PAGER = "bat";
    };
    systemPackages = with pkgs; [
      home-manager
      # # Archive Managers and Compression
      p7zip
      rar
      zip
      unrar
      unzip
      xarchiver
      peazip
      pcmanfm-qt
      doublecmd
      alacritty
      git-credential-keepassxc
      age
      sops
      gowall
      picard
      sherlock-launcher
      lutgen
      clamav
      argyllcms
      keyd
      xmobar
      mullvad-browser
      tor-browser
      firefox
      nyxt
      ungoogled-chromium
      # libsForQt5.qt5.qtgraphicaleffects # # Dependency for sddm theme(s).
      filezilla
      # # Utils
      discordchatexporter-cli
      nix-prefetch-git
      exiftool
      fuseiso
      # # Apps
      blender
      wgcf
      # inputs.nixvim-config.packages.${system}.default
      # upscayl # Image Upscaler
      # vesktop # Discord Client
      # teamspeak_client # Teamspeak Client
      # teamspeak5_client # Teamspeak Client
      feh # Image Viewer
      mpv # Video Player
      vlc # Video Player
      vlc-bittorrent
      qbittorrent # Torrent Clien
      # logmein-hamachi # Hamachi
      # haguichi # Hamachi Client
      anydesk # Remote Desktop Client
      localsend # File Sharing
      # pywalfox-native
      obsidian # Note
      keepassxc
      rxvt-unicode
      dmenu
      # ungoogled-chromium
      # floorp
      inputs.zen-browser.packages."${system}".default
      # fum
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
      nixfmt-rfc-style
      # nixfmt
      nil
      nixd
      love
      lua
      luarocks
      # # Wine
      wineWowPackages.staging
      winetricks
      protontricks
      protonup-qt
      # # Launchers and some utils
      (heroic.override {
        extraPkgs = pkgs: [
          gamescope
          gamemode
        ];
      })
      gamemode
      gamescope
      mangohud
      prismlauncher
      steamcmd
      (lutris.override {
        extraPkgs = pkgs: [
          # List package dependencies here
          gamescope
          gamemode
        ];
        extraLibraries = pkgs: [
          # List library dependencies here
          gamescope
          gamemode
        ];
      })
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
      chocolate-doom # DOOM Source Port.
      crispy-doom # DOOM Source Port.
      woof-doom # DOOM Source Port.
      dsda-doom # DOOM Source Port.
      dsda-launcher # DSDA-DOOM Launcher.
      eternity # DOOM Source Port.
    ];
  };

  fonts.fontDir.enable = true;
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    dejavu_fonts
    nerd-fonts.symbols-only
    nerd-fonts.iosevka
    nerd-fonts.fira-code
    iosevka
    inter
    overpass
  ];

  system.stateVersion = "24.11";
}

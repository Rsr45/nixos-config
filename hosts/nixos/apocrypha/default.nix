#############################################################
#                                                           #
#  Apocrypha - Main Desktop                                 #
#  NixOS running on Ryzen 7 2700X, RX Vega 56, 16 GB RAM    #
#                                                           #
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

      # ========== Network Configs ==========
      "hosts/common/optional/services/adguardhome.nix"
      "hosts/common/optional/services/dnscrypt-proxy.nix"

      # ========== Optional Configs ==========
      "hosts/common/optional/services/greetd.nix"
      "hosts/common/optional/services/kanata.nix"
      "hosts/common/optional/services/searxng.nix"
      # "hosts/common/optional/services/locate.nix"
      "hosts/common/optional/audio.nix"
      # "hosts/common/optional/firejail.nix"
      # "hosts/common/optional/plymouth.nix"
      "hosts/common/optional/wm/hyprland.nix"
      # "hosts/common/optional/wm/niri.nix"
      # "hosts/common/optional/wm/i3.nix"
      # "hosts/common/optional/wm/awesome.nix"
    ])
    # ========== Apocrypha Specific ========
    # ./stylix.nix
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
      # dnscrypt-cert-key = {
      #   # restartUnits = [ "dnscrypt-proxy.service" ];
      # };
      # nextcloud-admin = {
      #   owner = "nextcloud";
      # };
    };
  };

  networking = {
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    networkmanager = {
      # dns = "systemd-resolved";
      # insertNameservers = [
      #   "127.0.0.1"
      #   "::1"
      # ];
    };
  };

  i18n.extraLocaleSettings = {
    # LC_ALL = "en_US.UTF-8"; # This overrides all other LC_* settings.
    ## US no reason to change
    # LC_CTYPE = "en_US.UTF8";
    LC_MESSAGES = "en_US.UTF-8";
    ## EU Metric units , universal etc
    LC_MEASUREMENT = "en_IE.UTF-8";
    LC_TIME = "en_IE.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    # Localized
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_COLLATE = "tr_TR.UTF-8";
  };

  ## Disable Telemetry
  services.userdbd.enable = lib.mkForce false;
  # systemd.package = pkgs.systemd.override { withUserDb = false; }; ## cant be bothered to recompile

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  programs.kdeconnect.enable = true;

  networking.nftables.enable = true;
  networking.firewall = {
    enable = lib.mkForce true;
    # allowedTCPPorts = [
    #   53317
    # ];
    # allowedUDPPorts = [ 53317 ];
    # allowedTCPPortRanges = [
    #   {
    #     from = 1714;
    #     to = 1764;
    #   }
    # ];
    # allowedUDPPortRanges = [
    #   {
    #     from = 1714;
    #     to = 1764;
    #   }
    # ];
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

  boot.tmp.cleanOnBoot = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.logind.settings.Login.HandlePowerKey = "poweroff";

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
    xone = {
      enable = true;
    };
  };

  programs = {
    # adb.enable = true; # use android-tools
    appimage = {
      enable = true;
      binfmt = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # substituters = [
      #   "http://binarycache.example.com"
      #   "https://nix-community.cachix.org"
      #   "https://cache.nixos.org/"
      # ];
      # trusted-public-keys = [
      #   "binarycache.example.com-1:dsafdafDFW123fdasfa123124FADSAD"
      #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # ];
    };
  };

  # documentation = {
  #   dev.enable = true;
  #   man.cache.enable = true;
  #   nixos.includeAllModules = false;
  # };

  # environment.pathsToLink = [
  #   "/share/xdg-desktop-portal"
  #   "/share/applications"
  # ];
  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    # extraPortals = lib.mkForce [
    #   pkgs.kdePackages.xdg-desktop-portal-kde
    #   pkgs.xdg-desktop-portal-termfilechooser
    # ];
    # config = {
    #   common = {
    #     default = [
    #       "kde"
    #     ];
    #     "org.freedesktop.impl.portal.FileChooser" = [
    #       "termfilechooser"
    #     ];
    #   };
    #   #   pantheon = {
    #   #     default = [
    #   #       "pantheon"
    #   #       "gtk"
    #   #     ];
    #   #     "org.freedesktop.impl.portal.Secret" = [
    #   #       "gnome-keyring"
    #   #     ];
    #   #   };
    #   #   x-cinnamon = {
    #   #     default = [
    #   #       "xapp"
    #   #       "gtk"
    #   #     ];
    #   #   };
    # };
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

  # /etc/opt/edge/policies/managed/managed.json

  environment.etc."opt/edge/policies/managed/managed.json".source = ./managed.json;
  environment.etc."opt/edge/policies/recommended/recommended.json".source = ./recommended.json;

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
      kdePackages.ark
      kdePackages.kdenlive
      # kdePackages.dolphin
      # kdePackages.dolphin-plugins
      findutils
      p7zip
      rar
      zip
      unrar
      unzip
      xarchiver
      pcmanfm-qt
      # doublecmd
      # git-credential-keepassxc # using ssh with keepassxc as the agent
      age
      sops
      # mkcert
      # openssl
      # picard # music brainz tagger
      # sherlock-launcher
      # lutgen
      # gowall
      clamav
      # argyllcms # color management on x11
      # xmobar
      # tor-browser
      # ungoogled-chromium
      # libsForQt5.qt5.qtgraphicaleffects # # Dependency for sddm theme(s).
      # filezilla
      microsoft-edge
      # # Utils
      # discordchatexporter-cli
      nix-prefetch-git
      exiftool
      # fuseiso
      # # Apps
      # blender
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
      # anydesk # Remote Desktop Client
      # pywalfox-native
      obsidian # Note
      keepassxc
      # rxvt-unicode
      # dmenu
      # ungoogled-chromium
      # floorp
      # inputs.zen-browser.packages."${system}".default
      # inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      # fum
      # miru
      # dino
      gajim
      android-tools
      # element-desktop # Matrix Client
      # fluffychat # Matrix Client
      onlyoffice-desktopeditors
      # libreoffice-fresh
      (aspellWithDicts (
        dicts: with dicts; [
          en
          en-computers
          en-science
          tr
        ]
      ))
      hunspell
      hunspellDicts.tr_TR
      hunspellDicts.en_US
      # jdk # Java
      jdk17 # Java 17
      # jdk8 # Java 8
      # neovim
      neovide # Neovim GUI
      # btop # Resource Monitoring
      # # Language Server, Libraries, Compilers
      # glib
      # glibc
      # libgcc
      # gcc
      # ncurses
      # zig
      # clang
      # rustc
      # cargo
      # rust-analyzer
      # rustfmt
      # go
      # vala
      # alejandra
      # nixfmt-rfc-style
      nixfmt
      # nil
      # nixd
      # love
      # lua
      # luarocks
      man-pages
      # # Wine
      wineWow64Packages.staging
      winetricks
      # protontricks
      protonup-qt
      # # Launchers and some utils
      mangohud
      steamcmd
    ];
  };

  ## Font

  fonts.fontDir.enable = true;
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    iosevka
    inter
    # overpass
  ];
  fonts.fontconfig.enable = true;
  fonts.fontconfig.useEmbeddedBitmaps = true;

  system.stateVersion = "24.11";
}

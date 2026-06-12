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
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    (map lib.custom.relativeToRoot [
      # ========== Required Configs ==========
      "hosts/common/core"
      "shared/hosts/coreutils"

      # ========== Virtualisation ==========
      "hosts/common/optional/virtualisation/qemu.nix"

      # ========== Network Configs ==========
      # "hosts/common/optional/services/adguardhome.nix"
      "hosts/common/optional/services/dnscrypt-proxy.nix"
      # "hosts/common/optional/services/opensnitch.nix"
      "hosts/common/optional/services/syncthing.nix"

      # ========== DE/WM Configs ==========
      "hosts/common/optional/wm/hyprland.nix"
      "hosts/common/optional/wm/niri.nix"
      "hosts/common/optional/wm/sway.nix"
      # "hosts/common/optional/wm/i3.nix"
      # "hosts/common/optional/wm/awesome.nix"

      # ========== Optional Configs ==========
      "hosts/common/optional/services/greetd.nix"
      "hosts/common/optional/services/kanata.nix"
      "hosts/common/optional/services/searxng.nix"
      # "hosts/common/optional/services/ollama.nix"
      "hosts/common/optional/audio.nix"
      # "hosts/common/optional/firejail.nix"
      "hosts/common/optional/plymouth.nix"
      "shared/hosts/steam"
    ])
    # ========== Apocrypha Specific ========
    ./stylix.nix
  ];

  # ========== Host Specification ==========

  hostSpec = {
    hostName = "apocrypha";
  };

  networking = {
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
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

  security = {
    run0.enableSudoAlias = true;
    polkit.enable = true;
    sudo.enable = false;
    wrappers = {
      su.enable = lib.mkForce false;
      sudoedit.enable = lib.mkForce false;
      sg.enable = lib.mkForce false;
      # fusermount.enable = lib.mkForce false;
      # fusermount3.enable = lib.mkForce false;
      pkexec.setuid = lib.mkForce false;
      newgrp.setuid = lib.mkForce false;
      newgidmap.setuid = lib.mkForce false;
      newuidmap.setuid = lib.mkForce false;
      # `mount` Needed for `fileSystems.options`
      # mount.enable = lib.mkForce false;
      # Optional: if you disable mount, disable umount as well
      # umount.enable = lib.mkForce false;
    };
    # Or hyprlock, required for swaylock to accept your password
    pam.services.hyprlock = {
      text = ''
        auth include login
        account include login
        password include login
        session include login
      '';
    };
    pam.services.swaylock = {
      text = ''
        auth include login
        account include login
        password include login
        session include login
      '';
    };
  };

  systemd.coredump.enable = false;

  security = {
    protectKernelImage = true;
    # lockKernelModules = false; # this breaks iptables, wireguard, and virtd

    # force-enable the Page Table Isolation (PTI) Linux kernel feature
    forcePageTableIsolation = true;

    # User namespaces are required for sandboxing.
    # this means you cannot set `"user.max_user_namespaces" = 0;` in sysctl
    allowUserNamespaces = true;

    # Disable unprivileged user namespaces, unless containers are enabled
    unprivilegedUsernsClone = config.virtualisation.containers.enable;
    allowSimultaneousMultithreading = true;
  };

  services.chrony = {
    enable = true;
    enableNTS = true;
    servers = [
      "time.cloudflare.com iburst nts"
      "ntppool1.time.nl iburst nts"
      "nts.netnod.se iburst nts"
      "ptbtime1.ptb.de iburst nts"
      "time.dfm.dk iburst nts"
      "time.cifelli.xyz iburst nts"
    ];
    # havent worked out the kinks yet
    #  extraConfig = ''
    #      minsources 3
    #      authselectmode require

    #      # EF
    #      dscp 46

    #      driftfile /var/lib/chrony/drift
    #      dumpdir /var/lib/chrony
    #      ntsdumpdir /var/lib/chrony

    #      leapseclist /usr/share/zoneinfo/leap-seconds.list
    #      makestep 1.0 3

    #      rtconutc

    #      cmdport 0

    #      noclientlog
    #  '';
  };

  networking.nftables = {
    enable = true;
  };
  networking.firewall = {
    enable = lib.mkForce true;
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

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
      options = [ "discard" ];
    }
  ];

  boot.zswap.enable = true;

  systemd.oomd.enable = true;

  services = {
    xserver = {
      enable = true;
      autorun = true;
      videoDrivers = [ "amdgpu" ];
      xkb = {
        layout = "us";
        # variant = ""; # using kanata, keyd etc.
        options = "grp:alt_shift_toggle,compose:menu";
        extraLayouts = {
          mine = {
            description = "Turkish Q layout {swap i and ı, ESC and CAPS}";
            languages = [ "tur" ];
            symbolsFile = ./custom_tr.xkb;
          };
          secondcoming = {
            ## TODO: make i based on us but add alpha layer locale keys, more apt to call it kanata base layout
            description = "US Layout (Turkish Letters and Nordrassil)";
            languages = [ "us" ];
            symbolsFile = ./us_TR.xkb;
          };
        };
      };
    };
    clamav = {
      updater.enable = true;
      daemon.enable = true;
      updater.frequency = 12;
      scanner = {
        enable = true;
        # 4:00 AM
        interval = "*-*-* 04:00:00";
        scanDirectories = [
          "/home"
          "/var/lib"
          "/tmp"
          "/etc"
          "/var/tmp"
        ];
      };
    };
    gvfs.enable = true;
    tumbler.enable = true;
    flatpak.enable = true;
  };

  hardware = {
    amdgpu = {
      initrd = {
        enable = true;
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    xone = {
      enable = true;
    };
  };
  #FIXME: one of these slows everything check it out though i do not need aYthing of the sort for now but ehh
  # nixpkgs.config.rocmSupport = true;
  # hardware.amdgpu.opencl.enable = true;
  # services.lact.enable = true;
  # hardware.amdgpu.overdrive.enable = true;

  nixpkgs.config.allowUnfree = true;
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

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # environment.etc."opt/edge/policies/managed/managed.json".source = ./managed.json;
  # environment.etc."opt/edge/policies/recommended/recommended.json".source = ./recommended.json;

  environment = {
    localBinInPath = true;
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
      age
      sops
      nix-prefetch-git
      hydra-check
      # # Defaults
      clamav
      lynis
      kdePackages.ark
      kdePackages.kdenlive
      kdePackages.dolphin
      kdePackages.dolphin-plugins
      kdePackages.gwenview
      vlc
      vlc-bittorrent
      qbittorrent
      vim
      tor-browser

      kitty # must have term so we are not locked out in any wm
      foot
      alacritty

      # lutgen # change colors of wallpapers
      # gowall # change colors of wallpapers
      # upscayl # Image Upscaler
      # libsForQt5.qt5.qtgraphicaleffects # # Dependency for sddm theme(s).
      exiftool
      wgcf # cloudflare warp vpn/dns based account and wg conf creator
      feh # Image Viewer
      mpv # Video Player
      keepassxc
      gajim
      android-tools
      onlyoffice-desktopeditors
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
      jdk17 # Java 17

      # To make kde work on non kde
      kdePackages.kde-cli-tools
      (pkgs.writeTextFile {
        name = "minimal-applications-menu";
        text = ''
          <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
           "http://www.freedesktop.org/standards/menu-spec/1.0/menu.dtd">

          <Menu>
            <Name>Applications</Name>

            <!-- Search the default directories for .desktop files.
                 I.e. the /applications subdirectory of each entry in
                 $XDG_DATA_DIRS
            -->
            <DefaultAppDirs/>

            <!-- Menus and submenus can use localized names as well as icons
                 by referring to a .directory file. This configuration does
                 not use them, but add it to the search for future-proofing.
            -->
            <DefaultDirectoryDirs/>

            <!-- Add every .desktop entry in the search result to this
                 menu.
            -->
            <Include><All/></Include>

            <!-- List submenus before normal .desktop files in the menu. -->
            <DefaultLayout>
              <Merge type="menus"/>
              <Merge type="files" />
            </DefaultLayouts>

            <!-- Applications can add their own menu entries in
                 menus/applications-merged/. This will cause them to
                 be merged into this menu.
            -->
            <DefaultMergeDirs/>
          </Menu>
        '';
        destination = "/etc/xdg/menus/applications.menu";
      })
    ];
  };

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      ubuntu-sans
      ubuntu-sans-mono
    ];
    fontconfig.enable = true;
    fontconfig.useEmbeddedBitmaps = true;
  };

  system.stateVersion = "24.11";
}

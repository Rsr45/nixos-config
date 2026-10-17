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
  pkgsUnstable,
  ...
}: {
  imports = lib.flatten [
    # ============ Hardware Configs ==========
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    # overlay `xorg-server` to `xlibre-xserver`
    inputs.xlibre-overlay.nixosModules.overlay-xlibre-xserver

    # Overlay all drivers in this repo
    inputs.xlibre-overlay.nixosModules.overlay-all-xlibre-drivers

    (map lib.custom.relativeToRoot [
      # ========== Required Configs ==========
      "hosts/common/core"
      "shared/hosts/coreutils"
      "hosts/common/optional/audio.nix"
      "hosts/common/optional/services/kanata.nix"

      # ========== Security/Hardening ==========
      # "hosts/common/optional/security"
      # "hosts/common/optional/security/kernel/sysctl.nix"
      # "hosts/common/optional/security/kernel/parameters.nix"
      # "hosts/common/optional/security/systemd/systemd-journald"
      # "hosts/common/optional/firejail.nix"

      # ========== Virtualisation ==========
      # "hosts/common/optional/virtualisation/qemu.nix"

      # ========== Network Configs ==========
      "hosts/common/optional/services/dnscrypt-proxy.nix"
      "hosts/common/optional/services/adguardhome.nix"
      # "hosts/common/optional/services/opensnitch.nix"
      "hosts/common/optional/services/wireguard.nix"
      "hosts/common/optional/services/syncthing.nix"
      "hosts/common/optional/services/tor.nix"

      # ========== DE/WM Configs ==========
      # "hosts/common/optional/de/kde.nix"
      # "hosts/common/optional/wm/sway.nix"
      # "hosts/common/optional/wm/hyprland.nix"
      "hosts/common/optional/wm/awesome.nix"
      "hosts/common/optional/wm/hyprland.nix"

      # ========== Optional Configs ==========
      "hosts/common/optional/services/greetd.nix"
      "hosts/common/optional/services/searxng.nix"
      # "hosts/common/optional/plymouth.nix"
      "shared/hosts/steam"
    ])
    # ========== Apocrypha Specific ========
    ./stylix.nix
    ./systemPackages.nix
  ];

  # works on x11 not in hyprland
  services.gnome.gnome-keyring.enable = true;
  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
    # seems to fix for hyprland
    greetd-password.enableGnomeKeyring = true;
  };

  services.dbus = {
    brokerPackage = pkgs.dbus-broker.overrideAttrs (old: {
      patches =
        (old.patches or [])
        ++ [
          ./dbus-broker-logging.patch
        ];
    });
  };

  # if you installed Home Manager via its NixOS module and
  # ‘home-manager.useUserPackages’ is enabled, make sure to add
  # environment.pathsToLink = [
  #   "/share/xdg-desktop-portal"
  #   "/share/applications"
  # ];

  programs.gpu-screen-recorder = {
    enable = true;
    # ui.enable = true;
  };

  boot.kernelModules = [
    "v4l2loopback"
    "snd-aloop"
  ];

  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback.out
  ];

  boot.extraModprobeConfig = ''
    # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
    # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';

  # ========== Host Specification ==========

  hostSpec = {
    hostName = "apocrypha";
  };

  # ========== Custom Modules ==========
  modules.security.memoryAllocator = {
    enable = false;
    provider = "graphene-hardened";
  };

  networking = {
    networkmanager = {
      enable = true;
      wifi = {
        # backend = "iwd";
        scanRandMacAddress = true;
        macAddress = "random";
      };
    };
  };

  # ========== FileSystem and Swap ==========

  # fileSystems."/home/hare/.cache" = {
  #   device = "none";
  #   fsType = "tmpfs";
  #   options = [
  #     "size=4G"
  #     "mode=777"
  #   ];
  # };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
      options = ["discard"];
    }
  ];
  boot.zswap.enable = true;

  i18n.defaultLocale = "tr_TR.UTF-8";
  i18n.extraLocales = ["en_IE.UTF-8/UTF-8" "tr_TR.UTF-8/UTF-8"];
  i18n.extraLocaleSettings = {
    # LC_ALL = "en_US.UTF-8"; # This overrides all other LC_* settings.
    ## US no reason to change
    LC_CTYPE = "tr_TR.UTF8";
    LC_MESSAGES = "tr_TR.UTF-8";
    ## EU Metric units , universal etc
    # LC_MEASUREMENT = "en_IE.UTF-8";
    # LC_TIME = "en_IE.UTF-8";
    # turkish
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";

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

  services.userdbd.enable = lib.mkForce false;
  # systemd.package = pkgs.systemd.override { withUserDb = false; };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  programs.kdeconnect.enable = true;

  security = {
    run0.enable = true;
    run0.enableSudoAlias = true;
    polkit.enable = true;
    sudo.enable = false;
    wrappers = {
      su.enable = lib.mkForce false;
      sudoedit.enable = lib.mkForce false;
      sg.enable = lib.mkForce false;
      pkexec.setuid = lib.mkForce false;
      newgrp.setuid = lib.mkForce false;
      newgidmap.setuid = lib.mkForce false;
      newuidmap.setuid = lib.mkForce false;
    };
  };

  systemd.coredump.enable = false;
  security.pam.loginLimits = [
    {
      domain = "*"; # Applies to all users/sessions
      type = "-"; # Set both soft and hard limits
      item = "core"; # The soft/hard limit item
      value = "0"; # Core dumps size is limited to 0 (effectively disabled)
    }
  ];

  # security = {
  # force-enable the Page Table Isolation (PTI) Linux kernel feature
  # forcePageTableIsolation = true;

  # User namespaces are required for sandboxing.
  # this means you cannot set `"user.max_user_namespaces" = 0;` in sysctl
  # allowUserNamespaces = true;

  # Disable unprivileged user namespaces, unless containers are enabled
  # unprivilegedUsernsClone = config.virtualisation.containers.enable;
  # allowSimultaneousMultithreading = true;
  # };

  services.timesyncd.enable = lib.mkForce false;
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
  };

  networking.nftables.enable = true;
  networking.firewall.enable = lib.mkForce true;

  boot.loader = {
    systemd-boot.enable = false;
    limine.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.initrd = {
    systemd.enable = true;
  };

  boot.tmp.cleanOnBoot = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.logind.settings.Login.HandlePowerKey = "poweroff";

  systemd.oomd.enable = true;

  services = {
    xserver = {
      enable = true;
      autorun = true;
      videoDrivers = ["amdgpu"];
      xkb = {
        layout = "secondcoming";
        # variant = ""; # using kanata, keyd etc.
        # options = "grp:alt_shift_toggle,compose:menu";
        options = "compose:menu";
        extraLayouts = {
          mine = {
            description = "Turkish Q layout {swap i and ı, ESC and CAPS}";
            languages = ["tur"];
            symbolsFile = ./custom_tr.xkb;
          };
          secondcoming = {
            ## TODO: make i based on us but add alpha layer locale keys, more apt to call it kanata base layout
            description = "US Layout (Turkish Letters and Nordrassil)";
            languages = ["us"];
            symbolsFile = ./us_TR.xkb;
          };
        };
      };
    };
    clamav = {
      updater.enable = true;
      updater.frequency = 12;
      daemon.enable = false;
      scanner = {
        enable = false;
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
  hardware.amdgpu.opencl.enable = true;
  # services.lact.enable = true;
  # hardware.amdgpu.overdrive.enable = true;

  # Blende Hip support
  nixpkgs.config.rocmSupport = true;

  nixpkgs.config.allowUnfree = true;
  programs = {
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
      substituters = ["https://hyprland.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      # Required so non-root users are allowed to use the above substituter/keys.
      # Use @wheel for all sudo users, or list your username explicitly.
      trusted-users = ["root" "@wheel" "${config.hostSpec.username}" "hare" "admin"];
    };
  };

  # documentation = {
  #   dev.enable = true;
  #   man.cache.enable = true;
  #   nixos.includeAllModules = false;
  # };

  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications" "/share/zsh"];

  xdg.portal = {
    enable = true;
  };

  # environment.etc."opt/edge/policies/managed/managed.json".source = ./managed.json;
  # environment.etc."opt/edge/policies/recommended/recommended.json".source = ./recommended.json;

  # this allows you to access `pkgsUnstable` anywhere in your config
  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  home-manager.extraSpecialArgs = {
    pkgsUnstable = import inputs.nixpkgs-unstable {
      inherit (pkgs.stdenv.hostPlatform) system;
      inherit (config.nixpkgs) config;
    };
  };

  environment = {
    localBinInPath = true;
    sessionVariables = {
      # NIXOS_OZONE_WL = "1";
      # ADW_DISABLE_PORTAL = "1";
      NNN_PLUG = "p:preview-tui;s:kdeconnect;c:autojump;d:dups;m:nmount;f:fixname";
      NNN_FIFO = "/tmp/nnn.fifo";
      NNN_OPTS = "He";
      NNN_TRASH = "trash";
      # wayland
      WLR_NO_HARDWARE_CURSORS = 1;
      NIXOS_OZONE_WL = 1;
      MOZ_ENABLE_WAYLAND = 1;
      GDK_BACKEND = "wayland,x11";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      SDL_VIDEODRIVER = "wayland,x11";
      # font
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
    };
    variables = {
      # RUSTICL_ENABLE = "radeonsi";
      # ROC_ENABLE_PRE_VEGA = "1";
      # DOTNET_CLI_TELEMETRY_OPTOUT = "1";
      NNN_PLUG = "p:preview-tui;s:kdeconnect;c:autojump;d:dups;m:nmount;f:fixname";
      NNN_FIFO = "/tmp/nnn.fifo";
      NNN_OPTS = "He";
      NNN_TRASH = "trash";
    };
    systemPackages = with pkgs; [
      home-manager
      age
      sops
      nix-prefetch-git
      hydra-check
      nix-du
      # # Defaults
      clamav
      kdePackages.ark
      kdePackages.dolphin
      kdePackages.dolphin-plugins
      kdePackages.qtsvg
      kdePackages.kio # needed since 25.11
      kdePackages.kio-fuse #to mount remote filesystems via FUSE
      kdePackages.kio-extras #extra protocols support (sftp, fish and more)
      kdePackages.konsole
      pcmanfm-qt
      qbittorrent
      vim
      tor-browser
      copyq
      xclip
      xsel
      kernel-hardening-checker
      polkit_gnome
      seahorse

      xnviewmp
      kphotoalbum
      kitty
      foot
      alacritty
      # (st.overrideAttrs (oldAttrs: rec {
      #   src = fetchFromGitHub {
      #     owner = "LukeSmithxyz";
      #     repo = "st";
      #     rev = "8ab3d03681479263a11b05f7f1b53157f61e8c3b";
      #     sha256 = "1brwnyi1hr56840cdx0qw2y19hpr0haw4la9n0rqdn0r2chl8vag";
      #   };
      #   # Make sure you include whatever dependencies the fork needs to build properly!
      #   buildInputs = oldAttrs.buildInputs ++ [harfbuzz];
      #   # If you want it to be always up to date use fetchTarball instead of fetchFromGitHub
      #   # src = builtins.fetchTarball {
      #   #   url = "https://github.com/lukesmithxyz/st/archive/master.tar.gz";
      #   # };
      # }))

      (st.overrideAttrs (oldAttrs: rec {
        patches = [
          ./st-xresources-20260524-688f70a.diff
        ];
        # configFile = writeText "config.def.h" (builtins.readFile ./config.h);
        # postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
      }))
      physlock
      xsecurelock

      bfs
      pkgsUnstable.yt-dlp
      pkgsUnstable.gallery-dl
      imgbrd-grabber

      # lutgen # change colors of wallpapers
      # gowall # change colors of wallpapers
      # upscayl # Image Upscaler
      # libsForQt5.qt5.qtgraphicaleffects # # Dependency for sddm theme(s).
      exiftool
      wgcf # cloudflare warp vpn/dns based account and wg conf creator
      feh # Image Viewer
      mpv # Video Player
      keepassxc
      android-tools
      hunspell
      hunspellDicts.tr_TR
      hunspellDicts.en_US
      clinfo

      # To make kde-dolphin work on non kde
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
      vista-fonts
      corefonts
      atkinson-hyperlegible-next
      atkinson-hyperlegible-mono
      iosevka-bin

      nerd-fonts.symbols-only
      font-awesome

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];
    fontconfig.enable = true;
    fontconfig.useEmbeddedBitmaps = true;
  };

  system.stateVersion = "24.11";
}

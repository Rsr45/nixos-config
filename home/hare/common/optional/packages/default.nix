{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    # RSS Feed
    # bulletty # cool but no script
    newsboat
    pywalfox-native
    # Network/
    # bluetui
    # impala
    # Music
    cmus
    kew
    # Disk
    ncdu
    # Web
    nyaa
    lynx
    # elinks # build error
    links2
    gcc
    nyxt
    readability-cli
    # openmw

    lm_sensors
    ffmpeg-full
    ffmpegthumbnailer
    gifski

    # iamb
    xclip
    wl-clipboard
    ps3iso-utils
    ps3-disc-dumper
    kdePackages.kruler
    libnotify
    pwvucontrol
    ## Application Launchers
    rofi
    warp
    fsel
    python3
    enchant
    xdpyinfo
    obs-studio
    xdotool
    ## Screenshot and such
    grim
    slurp
    satty

    maim
    slop
    # OCR
    tesseract
    audacious
    xwayland-satellite

    awww
    tmux-sessionizer
    # disk space calc
    # best
    dua
    dust
    dysk

    wev
    # rmpc
    wiremix
    # doxx
    # broot
    trashy
    # --- Bar/Framework ---
    # inputs.quickshell.packages.${system}.default
    # inputs.noctalia.packages.${system}.default
    quickshell
    # inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    # inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli
    # --- MISC ---
    # just
    # mask
    # xh
    # du-dust
    # hyperfine
    # xan
    # uutils-coreutils
    # odin
    # cmake
    # libtool
    # graphviz
    # python314
    imagemagick

    aria2
    # ghostscript
    # mermaid-cli
    vicinae
    # nodejs
    # mlocate
    # --- 3DR ---
    freecad
    blender
    # --- EMU ---
    (heroic.override {
      extraPkgs =
        pkgs': with pkgs'; [
          gamescope
          gamemode
        ];
    })
    ppsspp
    pcsx2
    # uzdoom
    # crispy-doom # # use thi or dsda or woof>>
    # dsda-doom
    # woof-doom
    # eternity

    texliveFull
    libsecret
    ueberzugpp
    chafa
    kalker
    alejandra

    (writeShellScriptBin "tmux-sessionizer" ''
      #!/usr/bin/env bash

      if [[ $# -eq 1 ]]; then
          selected=$1
      else
          selected=$(find ~/Dev ~/Projects ~/ ~/Personal -mindepth 1 -maxdepth 1 -type d | fzf)
      fi

      if [[ -z $selected ]]; then
          exit 0
      fi

      selected_name=$(basename "$selected" | tr . _)
      tmux_running=$(pgrep tmux)

      if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
          tmux new-session -s $selected_name -c $selected
          exit 0
      fi

      if ! tmux has-session -t=$selected_name 2> /dev/null; then
          tmux new-session -ds $selected_name -c $selected
      fi

      tmux switch-client -t $selected_name
    '')
  ];
  # programs.mbsync.enable = true;
  # programs.msmtp.enable = true;
  programs = {
    # bat.enable = true;
    nnn.enable = true;
    ranger.enable = true;
    joshuto.enable = true;
    lf = {
      enable = true;
      extraConfig = ''
        cmd unarchive $\{{
          case "$f" in
            *.zip) unzip "$f" ;;
            *.rar) unrar x "$f" ;;
            *.tar.gz) tar -xzvf "$f" ;;
            *.tar.xz) tar -xf "$f" ;;
            *.tar.bz2) tar -xjvf "$f" ;;
            *.tar) tar -xvf "$f" ;;
            *.7z) 7z e "$f" ;;
            *) echo "Unsupported Format !!" ;;
          esac
        }}
      '';
    };
    # gitui.enable = true;
    # broot.enable = true;
    # zellij = {
    #   enable = true;
    #   # settings = {};
    # };
    ripgrep = {
      enable = true;
      arguments = [
        "--max-columns=469"
        "--max-columns-preview"
        "--smart-case"
        "--column"
        "--no-ignore"

        "--colors=line:style:intense"
        "--colors=line:fg:172"
        "--colors=column:fg:136"
        "--colors=match:fg:202"
        "--colors=match:style:bold"
        "--colors=path:style:intense"
        "--colors=path:fg:142"
        "--colors=path:style:underline"

        ## types

        # web
        "--type-add"
        "web:*.{html,css,php,phtml,md,js}*"

        # text
        "--type-add"
        "text:*.{txt,text,md}*"

        # ignore

        "--glob=!.cache/*"
        "--glob=!SteamLibrary/*"
        "--glob=!.steampath/*"
        "--glob=!.steampid/*"
        "--glob=!.wine/*"
        "--glob=!wineprefixes/*"
        "--glob=!Steam/*"
        "--glob=!.steam/*"

        # maybes

        "--glob=!.cargo/*"
        "--glob=!.gradle/*"
        "--glob=!.PlayOnLinux/*"
      ];
    };
    ripgrep-all.enable = true;
    fd.enable = true;
  };

  programs.lutris = {
    enable = false;
    defaultWinePackage = pkgs.proton-ge-bin;
    protonPackages = with pkgs; [ proton-ge-bin ];
    extraPackages = with pkgs; [
      mangohud
      winetricks
      gamescope
      gamemode
      umu-launcher
    ];
  };

  xdg.configFile = {
    "retroarch/system/scph5500.bin".source = lib.custom.relativeToRoot "shared/bios/ps1/scph5500.bin";
    "retroarch/system/scph5501.bin".source = lib.custom.relativeToRoot "shared/bios/ps1/scph5501.bin";
    "retroarch/system/scph5502.bin".source = lib.custom.relativeToRoot "shared/bios/ps1/scph5502.bin";
    "retroarch/system/psxonpsp660.bin".source =
      lib.custom.relativeToRoot "shared/bios/ps1/psxonpsp660.bin";
    "retroarch/system/ps1_rom.bin".source = lib.custom.relativeToRoot "shared/bios/ps1/ps1_rom.bin";
    "PCSX2/bios/ps2-0230a".source = lib.custom.relativeToRoot "shared/bios/ps2/ps2-0230a-20080220.bin";
    "PCSX2/bios/ps2-0230e".source = lib.custom.relativeToRoot "shared/bios/ps2/ps2-0230e-20080220.bin";
    "PCSX2/bios/ps2-0220h".source = lib.custom.relativeToRoot "shared/bios/ps2/ps2-0220h-20060210.bin";
    "PCSX2/bios/ps2-0210j".source = lib.custom.relativeToRoot "shared/bios/ps2/ps2-0210j-20040917.bin";

    "PCSX2/memcards".source =
      config.lib.file.mkOutOfStoreSymlink "${config.xdg.userDirs.extraConfig.GAMES}/ps2/memcards";
  };

  programs.retroarch = {
    enable = true;
    cores = {
      mgba.enable = true;
      snes9x = {
        enable = true;
        package = pkgs.libretro.snes9x2010;
      };
      swanstation.enable = true;
      beetle-psx-hw.enable = true;
      beetle-psx.enable = true;
      flycast.enable = true;
    };
    settings = {
      menu_driver = "xmb";
      savestate_auto_index = "true";
      sort_savefiles_by_content_enable = "true";
      sort_savefiles_enable = "true";
      sort_savestates_by_content_enable = "true";
      sort_savestates_enable = "true";
      savefiles_in_content_dir = "true";
      savestates_in_content_dir = "true";
      screenshots_in_content_dir = "true";
      # systemfiles_in_content_dir = "false"; # doub that will be good
    };
  };
  programs.prismlauncher = {
    enable = false;
  };

  programs = {
    vicinae = {
      enable = true;
      systemd.enable = true;
      settings = {
        providers = {
          applications = {
            preferences = {
              launchPrefix = "uwsm app --";
            };
          };
        };
      };
    };
  };
  programs.neovide.enable = true;
  programs.obsidian = {
    enable = true;
    cli.enable = true;
    vaults = {
      nix-roam = {
        target = "/Documents/Notes/";
        enable = true;
        # target = "";
        # settings = {
        #   corePlugins = {
        #     webviewer = {
        #       enable = true;
        #     };
        #     templates = {
        #       enable = false;
        #     };
        #     # webviewer = {
        #     #   enable = true;
        #     # };
        #     # webviewer = {
        #     #   enable = true;
        #     # };
        #     # webviewer = {
        #     #   enable = true;
        #     # };
        #     # webviewer = {
        #     #   enable = true;
        #     # };
        #   };
        # };
      };
    };
  };
}

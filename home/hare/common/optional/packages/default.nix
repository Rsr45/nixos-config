{
  pkgs,
  pkgsUnstable,
  config,
  inputs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # RSS Feed
    # bulletty # cool but no script
    newsboat
    python314Packages.pygments
    # runapp
    # kew
    droidcam
    # scrcpy
    wl-screenrec # gpu heavy
    wf-recorder # cpu heavy
    keepassxc
    uutils-coreutils
    shellcheck
    nsxiv

    bubblewrap
    moc
    cmus
    edir
    ouch
    pistol
    xcolor
    # inputs.tagstudio.packages.${pkgs.stdenv.hostPlatform.system}.tagstudio # build error
    hyprpicker

    # Music
    # kew

    dvtm
    gimp-with-plugins
    # Web
    # lynx
    # elinks # build error
    # links2
    # readability-cli
    # openmw
    lm_sensors
    htop
    ffmpeg-full
    ffmpegthumbnailer
    gifski
    wl-kbptr
    anki
    lyx

    # Media
    picard
    kid3-qt
    goldendict-ng
    pkgsUnstable.brave-origin
    vlc
    vlc-bittorrent
    # kdePackages.elisa
    gram
    qview
    qimgv
    audacious
    audacious-plugins
    musikcube
    # strawberry
    # pkgsUnstable.deadbeef-with-plugins
    # quodlibet-full
    # fooyin # flatpak is used
    qmmp

    ## Documents
    kdePackages.okular

    ## Creative
    krita
    kdePackages.kdenlive

    ## Util
    kdePackages.kleopatra

    mullvad-browser
    fluffychat

    metadata-cleaner

    awww
    vips
    epub-thumbnailer
    poppler-utils
    mediainfo
    ffmpegthumbnailer

    xclip
    xev
    wl-clipboard
    ps3iso-utils
    ps3-disc-dumper
    libnotify
    pwvucontrol
    ## Application Launchers
    rofi
    warp
    fsel
    python3
    enchant
    xdpyinfo
    xdotool

    darktable
    digikam
    shotwell
    ## Screenshot and such
    grim
    slurp
    satty

    maim
    tesseract
    xwayland-satellite

    # tmux-sessionizer

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
    # --- 3DR ---
    # freecad # vtk build error
    blender
    # --- EMU ---
    (heroic.override {
      extraPkgs = pkgs':
        with pkgs'; [
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

    texliveMedium
    libsecret
    ueberzugpp
    chafa

    bcal
    pdd
    kalker
    qalculate-qt

    alejandra
    pngquant

    oxipng

    (writeShellApplication {
      name = "screenshot-full";
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      runtimeInputs = with pkgs; [
        grim
        wl-clipboard
        exiftool
        libnotify
        coreutils
      ];
      text = ''
         # Define the directory and filename
         SCREENSHOT_DIR="''${XDGPICTURESDIR:-$HOME/Pictures}/Screenshots"
         FILENAME="$(date +'%Y%m%dT%H%M%S')__screenshot.png"
         FILEPATH="$SCREENSHOT_DIR/$FILENAME"
         USER_COMMENT="Screenshot"

        # Check if the capture was successful
         if grim "$FILEPATH"; then
             # Write to exif metadata Screenshot like in apple's scrennshot taken
             exiftool -overwrite_original -UserComment="$USER_COMMENT" "$FILEPATH"

             # Copy the image to the clipboard
             wl-copy < "$FILEPATH"

             # Send a success notification
             notify-send -i "$FILEPATH" "Full Screenshot Captured" "Saved to: $FILEPATH\nCopied to clipboard."
         else
             # Send an error notification
             notify-send -u critical "Screenshot Failed" "Could not capture the screen with grim."
         fi
      '';
    })

    (writeShellApplication {
      name = "screenshot-region";
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      runtimeInputs = with pkgs; [
        grim
        slurp
        wl-clipboard
        exiftool
        libnotify
        coreutils
      ];
      text = ''
        # Define the directory where screenshots will be saved.
        # Uses XDG Pictures directory if available, otherwise defaults to ~/Pictures/Screenshots.
        SCREENSHOT_DIR="''${XDGPICTURESDIR:-$HOME/Pictures}/Screenshots"

        # Define the filename with the current date and time.
        FILENAME="$(date +'%Y%m%dT%H%M%S')__screenshot_region.png"
        FILEPATH="$SCREENSHOT_DIR/$FILENAME"
        USER_COMMENT="Screenshot Region"

        # Prompt the user to select a region using slurp.
        # If a region is selected, slurp outputs the geometry.
        GEOMETRY=$(slurp || true)

        if [ -n "$GEOMETRY" ]; then
            if grim -g "$GEOMETRY" "$FILEPATH"; then
                # Set User Comment Field in Exif Metadata to Screenshot Region
                exiftool -overwrite_original -UserComment="$USER_COMMENT" "$FILEPATH"

                # Copy the saved image to the clipboard using wl-copy.
                wl-copy < "$FILEPATH"

                # Send a success notification with the file path and an icon.
                notify-send -i "$FILEPATH" "Screenshot Captured" "Saved to: $FILEPATH\nCopied to clipboard."
            else
                notify-send -u critical "Screenshot Failed" "Could not capture image with grim."
            fi
        else
            # Notify if the user cancelled the selection.
            notify-send "Screenshot Cancelled" "No region selected."
        fi
      '';
    })

    (writeShellApplication {
      name = "colorpicker";
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      runtimeInputs = with pkgs; [
        grim
        slurp
        wl-clipboard
        libnotify
        imagemagick
        coreutils
      ];
      text = ''
        showhelp() {
            echo "A basic wlroots compatible color picker script."
            echo ""
            echo "Usage:"
            echo "  wl-color-picker [options]"
            echo ""
            echo "Options:"
            echo "    --no-notify   Don't show a system notification of copied color"
            echo "    --help        Show this help"
        }

        NO_NOTIFY=0

        while [ "''${1-}" ]; do
            case $1 in
                '-h' | '--help' | 'help' | '?' )
                    showhelp
                    exit
                    ;;
                '--no-notify' )
                    NO_NOTIFY=1
                    ;;
            esac

            shift
        done

        # Check if running under wayland.
        if [ "$WAYLAND_DISPLAY" = "" ]; then
            echo "Error: This color picker must be run under a valid wayland session." >&2
            exit 1
        fi

        # Get color position
        position=$(slurp -b 00000000 -p)

        if [ -z "$position" ]; then
            exit 1 # User cancelled selection
        fi

        # Sleep at least for a second to prevent issues with grim always
        # returning improper color.
        sleep 1

        # Store the hex color value using graphicsmagick or imagemagick.
        if command -v /usr/bin/gm > /dev/null 2>&1; then
            color=$(grim -g "$position" -t png - \
                | /usr/bin/gm magick - -format '%[pixel:p{0,0}]' txt:- \
                | tail -n 1 \
                | rev \
                | cut -d ' ' -f 1 \
                | rev
            )
        else
            color=$(grim -g "$position" -t png - \
                | magick - -format '%[pixel:p{0,0}]' txt:- \
                | tail -n 1 \
                | cut -d ' ' -f 4
            )
        fi

        # Copy color to clipboard (Default behavior, same as old 'clipboard' command)
        echo "$color" | wl-copy -n

        if [ $NO_NOTIFY -ne 1 ]; then
            notify-send "Color copied to clipboard." "$color"
        fi
      '';
    })

    (writeShellApplication {
      name = "tmux-sessionizer";
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      runtimeInputs = with pkgs; [
        findutils
        procps
        tmux
        coreutils
      ];
      text = ''
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
            tmux new-session -s "$selected_name" -c "$selected"
            exit 0
        fi

        if ! tmux has-session -t="$selected_name" 2> /dev/null; then
            tmux new-session -ds "$selected_name" -c "$selected"
        fi

        tmux switch-client -t "$selected_name"
      '';
    })
  ];

  programs = {
    nnn.enable = true;
    ranger.enable = true;
    joshuto.enable = true;
    lf = {
      enable = true;
      extraConfig = ''
        set previewer ~/.config/lf/previewer
        set cleaner ~/.config/lf/cleaner
        set ifs "\n"
        set info custom

        cmd z %{{
            result="$(zoxide query --exclude "$PWD" "$@" | sed 's/\\/\\\\/g;s/"/\\"/g')"
            lf -remote "send $id cd \"$result\""
        }}

        cmd zi ''${{
            result="$(zoxide query -i | sed 's/\\/\\\\/g;s/"/\\"/g')"
            lf -remote "send $id cd \"$result\""
        }}

        cmd on-cd &{{
            zoxide add "$PWD"
        }}

        cmd on-load &{{
            cd "$(dirname "$1")" || exit 1
            [ "$(git rev-parse --is-inside-git-dir 2>/dev/null)" = false ] || exit 0

            cmds=""

            for file in "$@"; do
                case "$file" in
                    */.git|*/.git/*) continue;;
                esac

                status=$(git status --porcelain --ignored -- "$file" | cut -c1-2 | head -n1)

                if [ -n "$status" ]; then
                    cmds="''${cmds}addcustominfo ''${file} \"$status\"; "
                else
                    cmds="''${cmds}addcustominfo ''${file} '''; "
                fi
            done

            lf -remote "send $id :$cmds"
        }}

        cmd brename ''${{
            [ -n "$fs" ] && edir -- $fs || edir
        }}

        cmd remove ''${{
            if [ -z $fs ]; then
                rm -fr $f
            else
                IFS=':'; echo $fs | tr " " "\n"
                echo 'delete? [y/n]'
                read ans

                [ $ans = 'y' ] && (echo 'deleting files...' && rm -fr $fs) || (echo 'cancelled...')
            fi
        }}

        cmd fzf_search ''${{
            cmd="rg --column --line-number --no-heading --color=always --smart-case"
            fzf --ansi --disabled --layout=reverse --header="Search in files" --delimiter=: \
                --bind="start:reload([ -n {q} ] && $cmd -- {q} || true)" \
                --bind="change:reload([ -n {q} ] && $cmd -- {q} || true)" \
                --bind='enter:become(lf -remote "send $id select \"$(printf "%s" {1} | sed '\'''s/\\/\\\\/g;s/"/\\"/g'\''')\"")' \
                --preview='cat -- {1}' # Use your favorite previewer here (bat, source-highlight, etc.), for example:
                #--preview-window='+{2}-/2' \
                #--preview='bat --color=always --highlight-line={2} -- {1}'
                # Alternatively you can even use the same previewer you've configured for lf
                #--preview='~/.config/lf/cleaner; ~/.config/lf/previewer {1} "$FZF_PREVIEW_COLUMNS" "$FZF_PREVIEW_LINES" "$FZF_PREVIEW_LEFT" "$FZF_PREVIEW_TOP"'
        }}

        cmd extract ''${{
            set -f
            ouch decompress $fx
        }}

        cmd on-cd &{{
            # display repository status in your prompt
            if [ -d .git ] || [ -f .git ]; then
                branch="$(git branch --show-current 2>/dev/null)" || true
                remote="$(git config --get "branch.$branch.remote" 2>/dev/null)" || true
                url="$(git remote get-url "$remote" 2>/dev/null)" || true
                fmt="\033[32;1m%u@%h\033[0m:\033[34;1m%w\033[0m\033[33;1m [GIT BRANCH:> $branch >> $url]\033[0m"
            elif [ -d .hg ]; then
                hg="$(hg branch 2>/dev/null)" || true
                fmt="\033[32;1m%u@%h\033[0m:\033[34;1m%w\033[0m\033[33;1m [HG BRANCH:> $hg]\033[0m"
            elif [ -d .svn ]; then
                svn="$(svn info 2>/dev/null | awk '/^URL: /{print $2}')" || true
                fmt="\033[32;1m%u@%h\033[0m:\033[34;1m%w\033[0m\033[33;1m [SVN URL:> $svn]\033[0m"
            else
                fmt="\033[32;1m%u@%h\033[0m:\033[34;1m%d\033[0m\033[1m%f\033[0m"
            fi
            lf -remote "send $id set promptfmt \"$fmt\""
        }}

        cmd trash %trash $fx
        cmd total-file-size  %du -sh $fx | fzf

        map *n push :total-file-size<space>

        map d
        map dd delete
        map dD trash

        map \;
        map \;c push :z<space>

        map R brename

        map gs :fzf_search
      '';
    };
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
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  programs.lutris = {
    enable = true;
    defaultWinePackage = pkgs.proton-ge-bin;
    protonPackages = with pkgs; [proton-ge-bin];
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
    "PCSX2/covers".source =
      config.lib.file.mkOutOfStoreSymlink "${config.xdg.userDirs.extraConfig.GAMES}/ps2/covers";
    "PCSX2/sstates".source =
      config.lib.file.mkOutOfStoreSymlink "${config.xdg.userDirs.extraConfig.GAMES}/ps2/sstates";
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

  services.kdeconnect.enable = true;

  programs = {
    vicinae = {
      enable = true;
      # systemd.enable = false;
      settings = {
        "launcher_window" = {
          rounding = 0;
          "client_side_decorations" = {
            # "enabled": true,
            # // @Deprecated: prefer the top-level launcher_window.rounding.
            # // "rounding": 10,
            "border_width" = 2;
            #
            # // Draws drop shadows on the client side, ONLY if we are a layer surface.
            # // We assume that non layer surfaces may already have drop shadows drawn by the compositor.
            # // In order to play well with blur, we do NOT allow drop shadows if the compositor doesn't support
            # // the ext-background-effect protocol (which allows defining a specific region to blur).
            # # "shadow_size": 12
          };
        };

        "close_on_focus_loss" = true;
        "keybinding" = "emacs";
        "input_server" = {
          "enabled" = false;
        };
        "font" = {
          "rendering" = "native";
        };
        "providers" = {
          "applications" = {
            "preferences" = {
              "defaultAction" = "launch";
              # launchPrefix = "runapp";
            };
          };
          "clipboard" = {
            "enabled" = false;
            "preferences" = {
              # "encryption" = true;
              "eraseOnStartup" = true;
              "ignorePasswords" = false;
              "monitoring" = false;
            };
          };
          "developer" = {
            "enabled" = false;
          };
          "manage-shortcuts" = {
            "enabled" = false;
          };
          "raycast-compat" = {
            "enabled" = false;
          };
          "snippets" = {
            "enabled" = false;
          };
          "theme" = {
            "enabled" = false;
          };
        };
      };
    };
  };
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };

  programs.neovide.enable = true;
}

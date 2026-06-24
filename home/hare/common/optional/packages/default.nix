{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # RSS Feed
    # bulletty # cool but no script
    newsboat
    runapp
    pywalfox-native
    # Network/
    # bluetui
    # impala
    # Music
    # cmus
    # kew
    # Disk
    # ncdu
    # Web
    # nyaa
    # lynx
    # elinks # build error
    # links2
    # gcc
    # readability-cli
    # openmw
    lm_sensors
    ffmpeg-full
    ffmpegthumbnailer
    gifski
    palemoon-bin

    # iamb
    xclip
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

    tmux-sessionizer
    # disk space calc
    # best

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
    # nodejs
    # mlocate
    # --- 3DR ---
    freecad
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

    texliveFull
    libsecret
    ueberzugpp
    chafa
    kalker
    alejandra

    pngquant
    oxipng

    (writeShellApplication
      {
        name = "fzf-trash";
        bashOptions = ["errexit" "nounset" "pipefail"];
        runtimeInputs = with pkgs; [eza trashy libnotify fzf findutils coreutils];
        text = ''
          start=$(date +%s)

          files=$(eza -1 -a | fzf -m)

          if [ -n "$files" ]; then
              count=$(printf "%s\n" "$files" | wc -l | tr -d ' ')

              printf "%s\n" "$files" | xargs trash

              end=$(date +%s)

              duration=$((end - start))

              notify-send "Trash" "Deleted ''${count} files in ''${duration}s"
          fi
        '';
      })
    (writeShellApplication
      {
        name = "duplicate-images-after-comp";
        bashOptions = ["errexit" "nounset" "pipefail"];
        runtimeInputs = with pkgs; [gawk coreutils];
        text = ''
          dir="''${1:-.}"
          match_count=0
          diff_count=0
          missing_count=0

          echo "🔍 Scanning directory: $dir"
          echo "----------------------------------------"

          for f in "$dir"/*_1_comp.png; do
              [ -e "$f" ] || continue

              # Derive original name
              orig="''${f/_1_comp.png/_comp.png}"

              if [ -f "$orig" ]; then
                  hash1=$(sha256sum "$orig" | awk '{print $1}')
                  hash2=$(sha256sum "$f" | awk '{print $1}')

                  if [ "$hash1" == "$hash2" ]; then
                      echo "✅ MATCH: $(basename "$f")"
                      ((match_count++))
                  else
                      echo "❌ DIFFERENT: $(basename "$f")"
                      ((diff_count++))
                  fi
              else
                  echo "⚠️ MISSING ORIGINAL: $(basename "$f")"
                  ((missing_count++))
              fi
          done

          # Print Summary
          echo "----------------------------------------"
          echo "📊 SUMMARY:"
          echo "   ✅ Matches:        $match_count"
          echo "   ❌ Differences:    $diff_count"
          echo "   ⚠️ Missing Original: $missing_count"
          echo "   📁 Total Checked:  $((match_count + diff_count + missing_count))"
        '';
      })
    (writeShellApplication
      {
        name = "list-duplicates";
        bashOptions = ["errexit" "nounset" "pipefail"];
        runtimeInputs = with pkgs; [findutils coreutils];
        text = ''
          # Usage:
          #   ./find_duplicates.sh /path/to/directory       (Non-recursive, default)
          #   ./find_duplicates.sh -r /path/to/directory    (Recursive)
          #   ./find_duplicates.sh                          (Scans current directory, non-recursive)

          RECURSIVE=false
          DIR="."

          # Parse arguments
          while getopts "r" opt; do
            case $opt in
              r) RECURSIVE=true ;;
              \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
            esac
          done
          shift $((OPTIND-1))

          # Set directory if provided as argument
          if [ -n "$1" ]; then
            DIR="$1"
          fi

          if [ ! -d "$DIR" ]; then
            echo "Error: Directory '$DIR' not found"
            exit 1
          fi

          echo "🔍 Scanning for duplicates in: $DIR"
          if [ "$RECURSIVE" = true ]; then
            echo "Mode: Recursive (including subdirectories)"
          else
            echo "Mode: Non-recursive (current directory only)"
          fi
          echo "----------------------------------------"

          # Build the find command based on the toggle
          # -maxdepth 1 restricts search to the current directory only
          if [ "$RECURSIVE" = true ]; then
            FIND_CMD="find \"$DIR\" -type f"
          else
            FIND_CMD="find \"$DIR\" -maxdepth 1 -type f"
          fi

          # Execute checksum generation and duplicate detection
          # uniq -w 64 -D prints only lines with duplicate hashes (repeated groups)
          eval "$FIND_CMD" -exec sha256sum {} + 2>/dev/null | sort | uniq -w 64 -D

          echo "----------------------------------------"
          echo "✅ Scan complete. Lines above show duplicate groups."
        '';
      })

    (writeShellApplication
      {
        name = "screenshot-ocr";
        bashOptions = ["errexit" "nounset" "pipefail"];
        runtimeInputs = with pkgs; [grim slurp wl-clipboard libnotify tesseract coreutils];
        text = ''
          # Dependencies: grim, slurp, tesseract, wl-clipboard, libnotify
          # Ensure language packs are installed: tesseract-ocr-tur, tesseract-ocr-lat

          # Create a temporary file for the screenshot
          TMPFILE=$(mktemp /tmp/ocr_XXXXXX.png)

          # Cleanup function
          trap 'rm -f $TMPFILE' EXIT

          echo "Select the region to OCR..."

          # 1. Capture the selected region
          if ! grim -g "$(slurp)" "$TMPFILE"; then
              echo "Screenshot cancelled or failed."
              exit 1
          fi

          echo "Extracting text (Turkish + English + Latin)..."

          # 2. Run Tesseract with multi-language support
          # -l tur+eng+lat : Sets Turkish as primary, with English and Latin as secondary
          # --psm 6        : Assumes a single uniform block of text (good for snippets)
          TEXT=$(tesseract "$TMPFILE" - -l tur+eng+lat --psm 6 2>/dev/null)

          # Check if text was found
          if [ -z "$TEXT" ]; then
              notify-send "OCR Failed" "No text detected in the selected region."
              exit 0
          fi

          # 3. Copy to clipboard
          echo "$TEXT" | wl-copy

          # 4. Show notification
          PREVIEW="''${TEXT:0:50}$([ ''${#TEXT} -gt 50 ] && echo '...')"
          notify-send "OCR Complete" "Text copied to clipboard: $PREVIEW"

          echo "Text copied to clipboard!"
        '';
      })

    (writeShellApplication
      {
        name = "wallpaper-picker";
        bashOptions = ["errexit" "nounset" "pipefail"];
        runtimeInputs = with pkgs; [findutils coreutils awww vicinae];
        text = ''
          # Directory containing wallpapers
          WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

          # Find files, sort by modification time (newest first), strip timestamps, and pick one
          SELECTED=$(find "$WALLPAPER_DIR" -type f -printf '%T@ %p\n' | sort -rn | cut -d' ' -f2- | vicinae dmenu -p 'Pick a wallpaper...')

          # Apply wallpaper if a file was selected
          if [ -n "$SELECTED" ]; then
              if awww img "$SELECTED"; then
                  # Success notification
                  notify-send -i "$SELECTED" "Wallpaper Changed" "Successfully set: $(basename "$SELECTED")"
              else
                  # Error notification
                  notify-send -u critical "Error" "Failed to set wallpaper."
              fi
          fi
        '';
      })

    (writeShellApplication
      {
        name = "screenshot-full";
        bashOptions = ["errexit" "nounset" "pipefail"];
        runtimeInputs = with pkgs; [grim wl-clipboard exiftool libnotify coreutils];
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

    (writeShellApplication
      {
        name = "screenshot-region";
        bashOptions = ["errexit" "nounset" "pipefail"];
        runtimeInputs = with pkgs; [grim slurp wl-clipboard exiftool libnotify coreutils];
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
      name = "bookmarks";
      bashOptions = ["errexit" "nounset" "pipefail"];
      runtimeInputs = with pkgs; [
        procps
        gnused
        coreutils
        # rofi
        vicinae
      ];
      text = ''
        # DIR="$HOME/.config/rofi/themes/"
        # THEME="grimm"
        BOOKMARKS_FILE="$HOME/Personal/bookmarks/.bookmarks"
        browser() {
            if pgrep -x helium >/dev/null; then
                helium "$@"
            else
                floorp "$@"
            fi
        }

        if [[ ! -e "''${BOOKMARKS_FILE}" ]]; then
            touch "''${BOOKMARKS_FILE}"
        fi

        INPUT=$(vicinae dmenu -p "#B#" < "$BOOKMARKS_FILE")

        if   [[ $INPUT == "+"* ]]; then
            INPUT="''${INPUT#+}"
            if [[ $INPUT == *"."* ]]; then
                echo "$INPUT" >> "$BOOKMARKS_FILE"
            else
                INPUT="''${INPUT}.com" && echo "$INPUT" >> "$BOOKMARKS_FILE"
            fi
        elif [[ $INPUT == "_"* ]]; then
            INPUT="''${INPUT#_}" && sed -i "/$INPUT/d" "$BOOKMARKS_FILE"
        elif [[ $INPUT == *"."* ]]; then
            browser "$INPUT"
        elif [[ -z $INPUT  ]]; then
            exit 0
        else
            if pgrep -x helium >/dev/null; then
                helium -new-tab "https://www.duckduckgo.com/search?q=""$INPUT"""
            else
                floorp \
                    -search "$INPUT"
            fi
        fi
      '';
    })

    (writeShellApplication {
      name = "colorpicker";
      bashOptions = ["errexit" "nounset" "pipefail"];
      runtimeInputs = with pkgs; [grim slurp wl-clipboard libnotify imagemagick coreutils];
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
      bashOptions = ["errexit" "nounset" "pipefail"];
      runtimeInputs = with pkgs; [findutils procps tmux coreutils];
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
  services.awww.enable = true;
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
      systemd.enable = true;
      settings = {
        providers.applications.preferences = {
          launchPrefix = "runapp";
        };
      };
    };
  };

  programs.neovide.enable = true;
  # programs.obsidian = {
  #   enable = true;
  #   cli.enable = true;
  #   vaults = {
  #     nix-roam = {
  #       target = "/Documents/Notes/";
  #       enable = true;
  #       # target = "";
  #       # settings = {
  #       #   corePlugins = {
  #       #     webviewer = {
  #       #       enable = true;
  #       #     };
  #       #     templates = {
  #       #       enable = false;
  #       #     };
  #       #     # webviewer = {
  #       #     #   enable = true;
  #       #     # };
  #       #     # webviewer = {
  #       #     #   enable = true;
  #       #     # };
  #       #     # webviewer = {
  #       #     #   enable = true;
  #       #     # };
  #       #     # webviewer = {
  #       #     #   enable = true;
  #       #     # };
  #       #   };
  #       # };
  #     };
  #   };
  # };
}

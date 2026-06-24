{pkgs, ...}: {
  # programs.wallust.enable = true;

  xdg.configFile = {
    "wallust/templates" = {
      source = ./wal-templates;
      recursive = true;
    };
    "wallust/colorschemes" = {
      source = ./wal-colorschemes;
      recursive = true;
    };
  };

  home.packages = with pkgs; [
    (writeShellApplication {
      name = "wal-lust";
      bashOptions = ["errexit" "nounset" "pipefail"];
      runtimeInputs = with pkgs; [
        wallust
        coreutils
        python3
        procps
        pywalfox-native
      ];
      text = ''
        WALLPAPER=""
        THEME=""
        MODE=""

        COMMONALITY="$HOME/scripts/wallust/Commonality"
        ARCADW="$HOME/scripts/wallust/ArcAdw"

        while [ "$#" -gt 0 ]; do
          case "$1" in
            -w|--wallpaper)
              [ -n "''${2-}" ] || { echo "Error: missing value for $1"; exit 1; }
              WALLPAPER="$2"
              shift 2
              ;;
            -t|--theme)
              [ -n "''${2-}" ] || { echo "Error: missing value for $1"; exit 1; }
              THEME="$2"
              shift 2
              ;;
            -m|--mode)
              [ -n "''${2-}" ] || { echo "Error: missing value for $1"; exit 1; }
              MODE="$2"
              shift 2
              ;;
            *)
              echo "Usage: $0 -w <wallpaper path> -t <name> -m <mode/palette>"
              exit 1
              ;;
          esac
        done

        if [ -n "$WALLPAPER" ]; then
          wallust run "$WALLPAPER"
        fi

        if [ -n "$THEME" ]; then
          wallust cs "$THEME"
        fi

        if [ -n "$MODE" ]; then
          if [ -n "$WALLPAPER" ]; then
            wallust run "$WALLPAPER" -p "$MODE"
          fi
          if [ -n "$THEME" ]; then
            wallust cs "$THEME" -p "$MODE"
          fi
        fi

        python3 "$ARCADW/adwsvgDark.py"
        python3 "$ARCADW/changeAdwColors.py"
        python3 "$COMMONALITY/adwsvgDark.py"
        python3 "$COMMONALITY/changeAdwColors.py"

        pywalfox update

        pkill -SIGUSR1 kitty || true

        if pgrep waybar >/dev/null 2>&1; then
          pkill -SIGUSR2 waybar
        fi

        if pgrep eww >/dev/null 2>&1; then
          pkill eww && eww daemon
          eww open bar_1
        fi

        if pgrep dunst >/dev/null 2>&1; then
          dunstctl reload
        fi

        if pgrep awesome >/dev/null 2>&1; then
          echo 'awesome.restart()' | awesome-client
        fi
      '';
    })
  ];
}

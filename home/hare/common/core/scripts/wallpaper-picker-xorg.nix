{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "wallpaper-picker-xorg";
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      runtimeInputs = with pkgs; [
        findutils
        coreutils
        feh
        awww
        rofi
        vicinae
      ];
      text = ''
        WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

        SELECTED=$(if pgrep vicinae >/dev/null; then
            awww img "$(find ${config.xdg.userDirs.extraConfig.WALLPAPERS} | vicinae dmenu -p 'Pick a wallpaper...')"
          else
            find "$WALLPAPER_DIR" -type f -printf '%T@ %p\n' \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort -rn | cut -d' ' -f2- \
            | while read -r img; do
                 printf '%s\0icon\x1f%s\n' "$img" "$img"
             done \
              | rofi -dmenu -i -show-icons -theme "$HOME/.config/rofi/wallpaper.rasi"
          fi
        )

        [ -z "$SELECTED" ] && exit 0

        feh --bg-scale "$SELECTED"
        ln -sf "$SELECTED" ~/.current_wallpaper
      '';
    })
  ];
}

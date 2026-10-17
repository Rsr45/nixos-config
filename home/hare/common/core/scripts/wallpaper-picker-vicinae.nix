{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "wallpaper-picker-vicinae";
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      runtimeInputs = with pkgs; [
        findutils
        coreutils
        awww
        vicinae
      ];
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
  ];
}

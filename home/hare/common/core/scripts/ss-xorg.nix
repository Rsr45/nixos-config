{pkgs, ...}: {
  home.packages = with pkgs; let
    exifdata = "";
  in [
    (writeShellApplication {
      name = "ss-full";
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      runtimeInputs = with pkgs; [
        maim
        xclip
        exiftool
        libnotify
        coreutils
      ];
      text = ''
        SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
        TIMESTAMP="$(date +%s)"
        FILENAME="$(date -d "@$TIMESTAMP" '+%Y%m%dT%H%M%S')__screenshot.png"
        FILEPATH="$SCREENSHOT_DIR/$FILENAME"
        USER_COMMENT="Screenshot"

        maim "$FILEPATH"

        # Set User Comment Field in Exif Metadata to Screenshot Region
        # exiftool -overwrite_original -UserComment="$USER_COMMENT" "$FILEPATH"

        exiftool -overwrite_original -DateTimeOriginal="$(date -d "@$TIMESTAMP" '+%Y:%m:%d %H:%M:%S')" -CreateDate="$(date -d "@$TIMESTAMP" '+%Y:%m:%d %H:%M:%S')" -OffsetTimeOriginal="$(date -d "@$TIMESTAMP" '+%:z')" -OffsetTimeDigitized="$(date -d "@$TIMESTAMP" '+%:z')" -UserComment="$USER_COMMENT" "$FILEPATH"

        # Copy the saved image to the clipboard using wl-copy.
        xclip -selection clipboard -t image/png < "$FILEPATH"

        notify-send "Screenshot Captured" "Saved to: $FILEPATH"
      '';
    })

    (writeShellApplication {
      name = "ss-region";
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      runtimeInputs = with pkgs; [
        maim
        xclip
        exiftool
        libnotify
        coreutils
      ];
      text = ''
        SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
        TIMESTAMP="$(date +%s)"
        FILENAME="$(date -d "@$TIMESTAMP" '+%Y%m%dT%H%M%S')__screenshot_region.png"
        FILEPATH="$SCREENSHOT_DIR/$FILENAME"
        USER_COMMENT="Screenshot Region"

        maim -s "$FILEPATH"

        # Set User Comment Field in Exif Metadata to Screenshot Region
        # exiftool -overwrite_original -UserComment="$USER_COMMENT" "$FILEPATH"

        exiftool -overwrite_original -DateTimeOriginal="$(date -d "@$TIMESTAMP" '+%Y:%m:%d %H:%M:%S')" -CreateDate="$(date -d "@$TIMESTAMP" '+%Y:%m:%d %H:%M:%S')" -OffsetTimeOriginal="$(date -d "@$TIMESTAMP" '+%:z')" -OffsetTimeDigitized="$(date -d "@$TIMESTAMP" '+%:z')" -UserComment="$USER_COMMENT" "$FILEPATH"

        # Copy the saved image to the clipboard using wl-copy.
        xclip -selection clipboard -t image/png < "$FILEPATH"

        notify-send "Screenshot Captured" "Saved to: $FILEPATH"
      '';
    })
  ];
}

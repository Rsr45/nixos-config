{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "screenshot-ocr";
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
        tesseract
        coreutils
      ];
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
  ];
}

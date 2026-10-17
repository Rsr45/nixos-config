{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "compress-ss";
      runtimeInputs = with pkgs; [
        pngquant
        oxipng
        exiftool
      ];
      text = ''
        # PNG Screenshot Optimizer
        # first looks for _optimized in filename if found skips, then in exif Comment
        # field if found Compressed then skips if not found in either then processes
        # the files.

        # Configuration
        QUALITY_MIN=70
        QUALITY_MAX=90
        OXI_LEVEL="max"
        MARKER="compressed"

        INPUT_DIR="''${1:-.}"

        if [ ! -d "$INPUT_DIR" ]; then
            echo "Error: Directory '$INPUT_DIR' not found"
            exit 1
        fi

        echo "Optimizing PNGs in: $INPUT_DIR"
        echo "Logic: Append '$MARKER' to existing User Comment"
        echo "---"

        find "$INPUT_DIR" -type f -name "*.png" | while read -r file; do
            if [[ "$(basename "$file")" == *"_comp"* ]]; then
                continue
            fi

            filename=$(basename "$file")

            # 1. Extract existing comment
            existing_comment=$(exiftool -s -s -s -Comment "$file" 2>/dev/null)

            # 2. Check if already marked (Case-insensitive)
            if [[ "''${existing_comment,,}" == *"$MARKER"* ]]; then
                echo "Skipping: $filename (Comment already contains '$MARKER')"
                continue
            fi

            echo "Processing: $filename"
            echo "  → Current comment: ' ''${existing_comment:-[None]}'"

            original_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
            temp_file=$(mktemp --suffix=.png)
            rm -f -- "$temp_file"
            output_file="''${file%.png}_comp.png"

            # Stage 1: pngquant
            if ! pngquant --quality=$QUALITY_MIN-$QUALITY_MAX \
                          --speed 1 \
                          --skip-if-larger \
                          --output "$temp_file" \
                          "$file"; then
                cp "$file" "$temp_file"
            fi

            # Stage 2: oxipng
            oxipng --opt "$OXI_LEVEL" \
                   --out "$output_file" \
                   "$temp_file" 2>/dev/null

            rm -f "$temp_file"

            # Stage 3: exiftool (Smart Append)
            if [ -f "$output_file" ]; then
                if [ -z "$existing_comment" ]; then
                    # If no comment exists, just set the marker
                    exiftool -overwrite_original -Comment="$MARKER" "$output_file" 2>/dev/null
                    echo "  → Comment set to: '$MARKER'"
                else
                    # If comment exists, append " compressed" to it
                    # Syntax: -Comment<$Comment; " compressed" copies old + adds new
                    exiftool -overwrite_original "-Comment<\$Comment; $MARKER" "$output_file" 2>/dev/null
                    echo "  → Comment updated to: '$existing_comment $MARKER'"
                fi

                new_size=$(stat -f%z "$output_file" 2>/dev/null || stat -c%s "$output_file" 2>/dev/null)
                reduction=$(( (original_size - new_size) * 100 / original_size ))
                echo "  → Size reduced by ''${reduction}%"
            fi
        done

        echo "---"
        echo "Optimization complete!"
      '';
    })
  ];
}

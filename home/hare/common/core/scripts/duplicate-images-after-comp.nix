{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "duplicate-images-after-comp";
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      runtimeInputs = with pkgs; [
        gawk
        coreutils
      ];
      text = ''
        dir="''${1:-.}"
        match_count=0
        diff_count=0
        missing_count=0

        echo "🔍 Scanning directory: $dir"
        echo "----------------------------------------"

        for f in "$dir"/*_comp.png; do
            [ -e "$f" ] || continue

            # Derive original name
            orig="''${f/_comp.png}"

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
  ];
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "denote";
      runtimeInputs = with pkgs; [
        coreutils
      ];
      bashOptions = [
        "errexit"
      ];
      text = ''
        use_signature=false
        output_dir="$HOME/Documents/Notes"

        while [[ $# -gt 0 ]]; do
            case $1 in
                --signature)
                    use_signature=true
                    shift
                    ;;
                *)
                    printf 'Usage: %s [--signature]\n' "$0" >&2
                    exit 1
                    ;;
            esac
        done

        read -e -r -p 'New file TITLE: ' title_input
        title=$(denoteSanitizeTitle "$title_input")

        read -e -r -p 'New file KEYWORDS: ' keywords_input
        keywords=$(denoteSanitizeKeywords "$keywords_input")

        if $use_signature; then
            read -e -r -p 'New file SIGNATURE: ' signature_input
            signature=$(denoteSanitizeSignature "$signature_input")
        fi

        timestamp=$(date +%s)
        identifier=$(date -d "@$timestamp" '+%Y%m%dT%H%M%S')
        date=$(date -d "@$timestamp" '+%Y-%m-%dT%H:%M:%S%:z')


        if $use_signature; then
            filename="''${identifier}==''${signature}--''${title}__''${keywords}.md"
        else
            filename="''${identifier}--''${title}__''${keywords}.md"
        fi

        mkdir -p "$output_dir"

        filepath="''${output_dir%/}/$filename"

        touch "$filepath"

        # printf "---\ntitle:      \"$title_input\"\ndate:       $date\ntags:       [\"\"]\nidentifier: \"$identifier\"\n---" >> fileName
        tags=$(printf '%s' "''${keywords}" | sed 's/_/", "/g; s/^/"/; s/$/"/')

        if $use_signature; then
        cat >> "$filepath" <<EOF
        ---
        title:      "$title_input"
        date:       $date
        tags:       [$tags]
        identifier: "$identifier"
        signature:  "$signature"
        ---

        EOF
        else
        cat >> "$filepath" <<EOF
        ---
        title:      "$title_input"
        date:       $date
        tags:       [$tags]
        identifier: "$identifier"
        ---

        EOF
        fi

        printf '%s\n' "$filepath"
      '';
    })
  ];
}

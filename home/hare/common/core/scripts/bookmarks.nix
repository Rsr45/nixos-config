{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "bookmarks";
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      runtimeInputs = with pkgs; [
        procps
        gnused
        coreutils
        rofi
        vicinae
      ];
      text = ''
        BOOKMARKS_FILE="$HOME/Personal/bookmarks/.bookmarks"

        # browser() {
        #     if pgrep -x brave >/dev/null; then
        #         com.brave.Browser "$@"
        #     else
        #         mullvad-browser "$@"
        #     fi
        # }

        browser() {
            if [[ "$1" == *".onion"* ]]; then
                tor-browser --new-tab "$@"
            elif pgrep -x brave >/dev/null; then
                com.brave.Browser "$@"
            else
                org.mozilla.firefox "$@"
            fi
        }

        if [[ ! -e "$BOOKMARKS_FILE" ]]; then
            touch "$BOOKMARKS_FILE"
        fi

        # INPUT=$(rofi -dmenu -p "#B#" < "$BOOKMARKS_FILE")
        if pgrep vicinae >/dev/null; then
            # Vicinae is running
            INPUT=$(vicinae dmenu < "$BOOKMARKS_FILE")
        else
            # Vicinae is not running
            INPUT=$(rofi -dmenu -p "#B#" < "$BOOKMARKS_FILE")
        fi

        if [[ $INPUT == "+"* ]]; then
            INPUT="''${INPUT#+}"

            if [[ $INPUT == *" :: "* ]]; then
                URL="''${INPUT%% *}"
                TITLE="''${INPUT#* }"

                if [[ $URL == *"."* ]]; then
                    echo "$URL $TITLE" >> "$BOOKMARKS_FILE"
                else
                    echo "$URL.com $TITLE" >> "$BOOKMARKS_FILE"
                fi
            elif [[ $INPUT == *"."* ]]; then
                echo "$INPUT" >> "$BOOKMARKS_FILE"
            else
                INPUT="''${INPUT}.com" && echo "$INPUT" >> "$BOOKMARKS_FILE"
            fi
        # elif [[ $INPUT == "_"* ]]; then
        #     INPUT="''${INPUT#_}" && sed -i "/$INPUT/d" "$BOOKMARKS_FILE"
        elif [[ $INPUT == *" :: "* ]]; then
            URL="''${INPUT%% *}"
            browser "$URL"
        elif [[ $INPUT == *"."* ]]; then
            browser "$INPUT"
        elif [[ -z $INPUT ]]; then
            exit 0
        else
            if pgrep -x brave >/dev/null; then
                com.brave.Browser -new-tab "https://www.duckduckgo.com/search?q=""$INPUT"""
            else
                org.mozilla.firefox \
                    --new-tab "https://www.duckduckgo.com/search?q=""$INPUT"""
            fi
        fi
      '';
    })
  ];
}

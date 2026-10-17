{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "list-duplicates";
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      runtimeInputs = with pkgs; [
        findutils
        coreutils
      ];
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
  ];
}

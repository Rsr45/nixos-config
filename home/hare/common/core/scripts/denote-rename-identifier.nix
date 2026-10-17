{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "denoteRenameIdentifier";
      runtimeInputs = with pkgs; [
        coreutils
      ];
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      text = ''
        [[ $# -gt 0 ]] || {
            printf 'Usage: %s FILE...\n' "''${0##*/}" >&2
            exit 1
        }

        for file in "$@"; do
            [[ -f $file ]] || continue

            name=''${file%.*}
            ext=''${file##*.}

            [[ $name == "$file" ]] && continue

            # Extract the ID and everything after it.
            if [[ $name == @@* ]]; then
                rest=''${name#@@}

                # The custom ID ends at the first component prefix.
                id=$rest
                suffix='''

                for marker in -- == __; do
                    if [[ $rest == *"$marker"* ]]; then
                        before=''${rest%%"$marker"*}

                        if [[ ''${#before} -lt ''${#id} ]]; then
                            id=$before
                            suffix="''${rest:''${#before}}"
                        fi
                    fi
                done

                prefix='@@'

            elif [[ $name =~ ^([0-9]{8}T[0-9]{6})(.*)$ ]]; then
                id=''${BASH_REMATCH[1]}
                suffix=''${BASH_REMATCH[2]}
                prefix='''

            else
                continue
            fi

            read -e -r -i "$id" -p "ID [$file]: " id_input

            # id=$(denoteSanitizeIdentifier "$id_input")
            id="$id_input"

            [[ -n $id ]] || {
                printf 'Skipping: cleaned ID is empty: %s\n' "$file" >&2
                continue
            }

            # Standard ID does not use @@.
            if [[ $id =~ ^[0-9]{8}T[0-9]{6}$ ]]; then
                prefix='''
            else
                prefix='@@'
            fi

            newfile="''${prefix}''${id}''${suffix}.''${ext}"

            [[ $file == "$newfile" ]] && continue

            if [[ -e $newfile ]]; then
                printf 'Skipping: %s already exists\n' "$newfile" >&2
                continue
            fi

            printf '%s -> %s\n' "$file" "$newfile"
            mv -- "$file" "$newfile"
        done
      '';
    })
  ];
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "denoteRenameSignature";
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

            filename=''${file##*/}
            name=''${filename%.*}
            ext=''${filename##*.}

            [[ $name == "$filename" ]] && continue

            idpart='''
            rest=$name

            # Standard timestamp ID.
            if [[ $rest =~ ^[0-9]{8}T[0-9]{6} ]]; then
                idpart=''${rest:0:15}
                rest=''${rest:15}

            # Custom @@ ID. Stop at the first component prefix.
            elif [[ $rest == @@* ]]; then
                tmp=''${rest:2}
                pos=''${#tmp}

                for marker in -- == __; do
                    if [[ $tmp == *"$marker"* ]]; then
                        candidate=''${tmp%%"$marker"*}
                        [[ ''${#candidate} -lt $pos ]] && pos=''${#candidate}
                    fi
                done

                idpart="@@''${tmp:0:pos}"
                rest=''${tmp:pos}
            fi

            signature='''
            prefixes=()
            values=()

            # Parse components in their original order.
            while [[ -n $rest ]]; do
                component=''${rest:0:2}

                case $component in
                    --|==|__)
                        ;;
                    *)
                        break
                        ;;
                esac

                value=''${rest:2}
                pos=''${#value}

                for marker in -- == __; do
                    if [[ $value == *"$marker"* ]]; then
                        candidate=''${value%%"$marker"*}
                        [[ ''${#candidate} -lt $pos ]] && pos=''${#candidate}
                    fi
                done

                value=''${value:0:pos}

                prefixes+=("$component")
                values+=("$value")

                [[ $component == == ]] && signature=$value

                rest=''${rest:2+pos}
            done

            read -e -r -i "$signature" \
                -p "Signature [$file]: " signature_input

            # signature=$(denoteSanitizeSignature "$signature_input")
            signature="$signature_input"

            newrest='''
            found=false

            for i in "''${!prefixes[@]}"; do
                component=''${prefixes[i]}
                value=''${values[i]}

                if [[ $component == == ]]; then
                    value=$signature
                    found=true
                fi

                [[ -n $value ]] && newrest+="''${component}''${value}"
            done

            # No existing signature component: append it.
            if ! $found && [[ -n $signature ]]; then
                newrest+="==''${signature}"
            fi

            newfile="''${idpart}''${newrest}.''${ext}"

            [[ $filename == "$newfile" ]] && continue

            directory=''${file%/*}
            [[ $directory == "$file" ]] && directory='.'

            destination="''${directory}/''${newfile}"

            if [[ -e $destination ]]; then
                printf 'Skipping: %s already exists\n' "$destination" >&2
                continue
            fi

            printf '%s -> %s\n' "$file" "$destination"
            mv -- "$file" "$destination"
        done
      '';
    })
  ];
}

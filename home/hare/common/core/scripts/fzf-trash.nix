{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "fzf-trash";
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      runtimeInputs = with pkgs; [
        eza
        trashy
        libnotify
        fzf
        findutils
        coreutils
      ];
      text = ''
        start=$(date +%s)

        files=$(eza -1 -a | fzf -m)

        if [ -n "$files" ]; then
            count=$(printf "%s\n" "$files" | wc -l | tr -d ' ')

            printf "%s\n" "$files" | xargs trash

            end=$(date +%s)

            duration=$((end - start))

            notify-send "Trash" "Deleted ''${count} files in ''${duration}s"
        fi
      '';
    })
  ];
}

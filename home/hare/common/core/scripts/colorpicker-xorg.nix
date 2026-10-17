{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "colorpicker-xorg";
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      runtimeInputs = with pkgs; [
        maim
        xclip
        libnotify
        xdotool
        maim
        imagemagick
        coreutils
      ];
      text = ''
        eval "$(xdotool getmouselocation --shell)"

        color=$(maim -g "1x1+$X+$Y" |
            magick - -format '%[pixel:p{0,0}]' txt:- |
            awk -F'[()]' 'NR==2 {print $2}')

        hex=$(printf '%s' "$color" |
            magick - -format '#%[hex:u]' txt:-)

        printf '%s' "$hex" | xclip -selection clipboard
        printf '%s\n' "$hex"
      '';
    })
  ];
}

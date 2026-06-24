{
  config,
  pkgs,
  ...
}: let
  link = config.lib.file.mkOutOfStoreSymlink;
  colors = ''
    pragma Singleton
    import Quickshell
    import QtQuick

    Singleton {
        property color bg: "#${config.lib.stylix.colors.base00}"
        property color bgAlt: "#${config.lib.stylix.colors.base01}"
        property color border: "#${config.lib.stylix.colors.base02}"
        property color fg: "#${config.lib.stylix.colors.base05}"
        property color accent: "#${config.lib.stylix.colors.base0B}"
        property color accentDarker: "#69847A"
        property color accent2: "#${config.lib.stylix.colors.base0C}"
        property color accent2Darker: "#C89726"

        property color backgroundColor: "#282828"
        property color foregroundColor: "#D5C4A1"
        property color indicatorBGColor: "#5C746A"
        property color borderColor: "#282828"
        property color moduleBG: "#2A2A2A"
        property color accentColor: "#83A598"
        property color accent2Color: "#83A598"
        property color gradientAccent2Color: "#83A598"  //bottom / right of volume bar
        property color errorColor: "#9A4235"
        property color shadowColor: "#CC784d37"  // this applies to the dashboard shadow as well. you can disable shadow from config
    }
  '';
in {
  programs.quickshell = {
    enable = true;
    systemd.enable = false;
  };
  # xdg.configFile = {
  #   "quickshell" = {
  #     source = link ./quickshell;
  #     recursive = true;
  #   };
  #   "quickshell/shared/Colors.qml".text = link colors;
  # };

  xdg.configFile = {
    "quickshell".source = pkgs.runCommand "qs-config" {} ''
      set -euo pipefail
      mkdir -p $out/shared

      cp -r ${./quickshell}/. $out/

      cat > $out/shared/Colors.qml <<EOF
      ${colors}
      EOF
    '';

    "qs-dwm".source = pkgs.runCommand "qs-config" {} ''
      set -euo pipefail
      mkdir -p $out/shared

      cp -r ${./qs-dwm}/. $out/

      cat > $out/shared/Colors.qml <<EOF
      ${colors}
      EOF
    '';

    "qs-sway".source = ./qs-sway;
    "qs-hyprland".source = ./qs-hyprland;
  };
}

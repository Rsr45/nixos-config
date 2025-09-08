{ pkgs, config, ... }:
{
  programs.urxvt = {
    enable = true;
    package = pkgs.rxvt-unicode;
    fonts = [
      "xft:${config.stylix.fonts.monospace.name} Mono:antialias=true:size=14"
    ];
    extraConfig = {
      boldFont = "xft:${config.stylix.fonts.monospace.name} Mono:antialias=true:size=14";
      # letterSpace = "2";
    };
    scroll.bar.enable = false;
  };
}

# Using stylix to set fonts
{ pkgs, ... }:
{
  fonts.fontconfig = {
    enable = true;
    hinting = "slight";
    antialiasing = true;
    subpixelRendering = "rgb";
    defaultFonts = {
      monospace = [
        "Geist Mono"
        "Iosevka"
        "Symbols Nerd Font"
      ];
      sansSerif = [
        "Geist"
        "Inter"
        "Cantarell"
        "Noto Color Emoji"
        "Symbols Nerd Font"
      ];
      serif = [
        "Geist"
        "Inter"
        "Cantarell"
        "Noto Color Emoji"
        "Symbols Nerd Font"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  gtk.font = {
    name = "Geist";
  };

  home.packages = with pkgs; [
    tamzen
    terminus_font
    ibm-plex
    geist-font
    inter
    cantarell-fonts
    # kirsch
    nerd-fonts.symbols-only
    font-awesome
    material-symbols
    iosevka
  ];

  # is it even make a difference ???
  # home.sessionVariables = {
  #   FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  # };
}

{ pkgs, ... }:
{
  gtk.font = {
    package = pkgs.geist-font;
    name = "Geist";
    size = 12;
  };

  # qt = {
  #   qt5ctSettings = {
  #     Appearance = {
  #       style = "kvantum";
  #       icon_theme = "Papirus-Dark";
  #       standar_dialogs = "xdgdesktopportal";
  #     };
  #     Fonts = {
  #       fixed = "\"Iosevka,12\"";
  #       general = "\"Geist,12\"";
  #     };
  #   };
  #   qt6ctSettings = {
  #     Appearance = {
  #       style = "kvantum";
  #       icon_theme = "Papirus-Dark";
  #       standar_dialogs = "xdgdesktopportal";
  #     };
  #     Fonts = {
  #       fixed = "\"Iosevka,12\"";
  #       general = "\"Geist,12\"";
  #     };
  #   };
  # };

  fonts.fontconfig = {
    enable = true;
    hinting = "slight";
    antialiasing = true;
    subpixelRendering = "rgb";
    defaultFonts = {
      monospace = [
        # "Geist Mono"
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
    configFile = {
      # commit-mono-options = {
      #   enable = true;
      #   priority = 80;
      #   source = "./resources/fontconfig/commit-mono.conf";
      # };
      tamzen = {
        enable = true;
        label = "tamzen-disable-antialiasing";
        priority = 90;
        text = ''
          <?xml version="1.0"?>
          <!DOCTYPE fontconfig SYSTEM "fonts.dtd">

          <fontconfig>
            <description>Disable anti-aliasing for Tamzen since it is a bitmap font</description>
            <match target="pattern">
              <test name="family" compare="eq" qual="any">
                <string>Tamzen</string>
              </test>
              <edit name="antialias" mode="assign">
                <bool>false</bool>
              </edit>
            </match>
          </fontconfig>
        '';
      };
    };
  };

  home.packages = with pkgs; [
    tamzen
    roboto
    alegreya
    terminus_font
    ibm-plex
    geist-font
    inter
    cantarell-fonts
    # kirsch
    iosevka
    nerd-fonts.geist-mono
    nerd-fonts.symbols-only
    font-awesome
    material-symbols
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    papirus-icon-theme
  ];

  # is it even make a difference ???
  # home.sessionVariables = {
  #   FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  # };
}

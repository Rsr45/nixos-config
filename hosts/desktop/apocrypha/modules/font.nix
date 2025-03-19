{pkgs, ...}: {
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["GeistMono Nerd Font"];
      sansSerif = [
        "Geist"
        "Noto Color Emoji"
        "Symbols Nerd Font"
      ];
      serif = [
        "Noto Serif"
        "Noto Color Emoji"
        "Symbols Nerd Font"
      ];
      emoji = ["Noto Color Emoji"];
    };
  };
  # gtk.font = {
  #   name = "Geist";
  # };
  home.packages = with pkgs; [
    geist-font
    ibm-plex
    noto-fonts
    nerd-fonts.geist-mono
    nerd-fonts.blex-mono
    nerd-fonts.symbols-only
    font-awesome
    noto-fonts-color-emoji
  ];
}

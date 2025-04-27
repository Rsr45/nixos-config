{pkgs, ...}: {
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["FiraCode Nerd Font"];
      sansSerif = [
        "Cantarell"
        "Noto Color Emoji"
        "Symbols Nerd Font"
      ];
      serif = [
        "Cantarell"
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
    cantarell-fonts
    noto-fonts
    nerd-fonts.geist-mono
    nerd-fonts.blex-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
    font-awesome
    noto-fonts-color-emoji
  ];
}

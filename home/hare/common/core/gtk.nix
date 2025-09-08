{ config, ... }:
{
  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3 = {
      bookmarks = [
        "file://${config.home.homeDirectory}/Documents"
        "file://${config.home.homeDirectory}/Downloads"
        "file://${config.home.homeDirectory}/Music"
        "file://${config.home.homeDirectory}/Pictures"
        "file://${config.home.homeDirectory}/Videos"
        "file://${config.home.homeDirectory}/Games"
        "file://${config.home.homeDirectory}/Projects"
        "file://${config.home.homeDirectory}/Dev"
        "file://${config.home.homeDirectory}/Personal"
      ];
    };
  };
}

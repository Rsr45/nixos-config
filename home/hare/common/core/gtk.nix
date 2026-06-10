{ config, ... }:
{
  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3 = {
      bookmarks = [
        "file://${config.xdg.userDirs.documents}"
        "file://${config.xdg.userDirs.download}"
        "file://${config.xdg.userDirs.music}"
        "file://${config.xdg.userDirs.pictures}"
        "file://${config.xdg.userDirs.videos}"
        "file://${config.xdg.userDirs.extraConfig.GAMES}"
        "file://${config.xdg.userDirs.extraConfig.PROJECTS}"
        "file://${config.xdg.userDirs.extraConfig.DEV}"
        "file://${config.xdg.userDirs.extraConfig.PERSONAL}"
      ];
    };
  };
}

{ config, ... }:
{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = true;
      extraConfig = {
        DEV = "${config.home.homeDirectory}/Dev";
        PERSONAL = "${config.home.homeDirectory}/Personal";
        PROJECTS = "${config.home.homeDirectory}/Projects";
        GAMES = "${config.home.homeDirectory}/games";
        SCREENSHOTS = "${config.xdg.userDirs.pictures}/Screenshots";
        WALLPAPERS = "${config.xdg.userDirs.pictures}/Wallpapers";
        YT = "${config.xdg.userDirs.videos}/Youtube";
        VIDMISC= "${config.xdg.userDirs.videos}/Misc";
        NET = "${config.xdg.userDirs.videos}/clearnet";
      };
    };
  };
}

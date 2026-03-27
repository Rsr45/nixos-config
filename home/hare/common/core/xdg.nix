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
        GAMES = "${config.home.homeDirectory}/Games";
        SCREENSHOTS = "${config.xdg.userDirs.pictures}/Screenshots";
        WALLPAPERS = "${config.xdg.userDirs.pictures}/Wallpapers";
        YOUTUBEMUSIC = "${config.xdg.userDirs.music}/Youtube";
        YOUTUBE = "${config.xdg.userDirs.videos}/Youtube";
      };
    };
  };
}

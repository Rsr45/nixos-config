{ config, ... }:
{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_DEV_DIR = "${config.home.homeDirectory}/Dev";
        XDG_PERSONAL_DIR = "${config.home.homeDirectory}/Personal";
        XDG_PROJECTS_DIR = "${config.home.homeDirectory}/Projects";
        XDG_GAMES_DIR = "${config.home.homeDirectory}/Games";
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
        XDG_WALLPAPERS_DIR = "${config.xdg.userDirs.pictures}/Wallpapers";
        XDG_YOUTUBEMUSIC_DIR = "${config.xdg.userDirs.music}/Youtube";
        XDG_YOUTUBE_DIR = "${config.xdg.userDirs.videos}/Youtube";
      };
    };
  };
}

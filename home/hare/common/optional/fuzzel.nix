{ lib, config, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        include = "${config.xdg.configHome}/fuzzel/colors.ini";
      };
      border = {
        radius = "0";
        width = "2";
      };
    };
  };
}

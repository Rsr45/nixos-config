{ config, ... }:
{
  programs.foot = {
    enable = true;
    # settings = {
    #   # main = {
    #   #   # include = "${config.xdg.configHome}/foot/colors.ini";
    #   #   font = "Iosevka:size=12";
    #   # };
    # };
  };
}

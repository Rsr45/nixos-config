{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
    waypaper
    hyprsunset
  ];

  home.file = {
    ".config/hypr/hyprpaper.conf".text = ''preload = /home/hare/Pictures/Wallpapers/City.png'';
  };
}

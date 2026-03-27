{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprlock
  ];
  # programs.hyprlock = {
  #   enable = true;
  #   # settings = {
  #   #   general = {
  #   #     hide_cursor = true;
  #   #   };
  #   # };
  # };
}

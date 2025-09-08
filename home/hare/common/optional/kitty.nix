{ pkgs, ... }:
{
  home.packages = [ pkgs.kitty ];
  # programs.kitty = {
  #   enable = true;
  #   # settings = {
  #   #   text_composition_strategy = "legacy";
  #   #   confirm_os_window_close = "0";
  #   #   window_padding_width = "4";
  #   # };
  #   # themeFile = "matugen";
  # };
}

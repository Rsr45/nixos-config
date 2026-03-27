{ pkgs, ... }:
{
  home.packages = with pkgs; [
    matugen
    pywalfox-native
  ];
  xdg.configFile = {
    "matugen/templates" = {
      source = ./templates;
      recursive = true;
    };
  };
}

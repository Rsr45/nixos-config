{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wlr-which-key
  ];
  xdg.configFile = {
    "wlr-which-key" = {
      source = ./wlr-which-key;
      recursive = true;
    };
  };
}

{ pkgs, ... }:
{
  qt.kvantum = {
    enable = true;
    settings = {
      # Applications = {
      #   KvArc = [
      #     "app1"
      #     "app2"
      #   ];
      #   KvFlat = [
      #     "app3"
      #   ];
      # };
      General = {
        theme = "MaterialCommonality";
      };
    };
    themes = with pkgs; [
      gruvbox-kvantum
      catppuccin-kvantum
    ];
  };

  xdg.configFile = {
    "Kvantum/commonality" = {
      source = ./commonality;
      recursive = true;
    };
    "Kvantum/catppuccin-frappe-green" = {
      source = ./catppuccin-frappe-green;
      recursive = true;
    };
  };
}

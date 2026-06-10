{
  lib,
  pkgs,
  config,
  ...
}: let
  commonality-base16 = let
    kvconfig = config.lib.stylix.colors {
      template = lib.custom.relativeToRoot "shared/commonality.svg.mustache";
      extension = ".kvconfig";
    };
    svg = config.lib.stylix.colors {
      template = ./kvantum.svg.mustache;
      extension = ".svg";
    };
  in
    pkgs.runCommandLocal "base16-kvantum" {} ''
      directory="$out/share/Kvantum/myBase16Kvantum"
      mkdir --parents "$directory"
      cp ${kvconfig} "$directory/myBase16Kvantum.kvconfig"
      cp ${svg} "$directory/myBase16Kvantum.svg"
    '';
myKvantumPackage = let
    kvconfig = config.lib.stylix.colors {
      template = ./kvconfig.mustache;
      extension = ".kvconfig";
    };
    svg = config.lib.stylix.colors {
      template = ./kvantum.svg.mustache;
      extension = ".svg";
    };
  in
    pkgs.runCommandLocal "base16-kvantum" {} ''
      directory="$out/share/Kvantum/myBase16Kvantum"
      mkdir --parents "$directory"
      cp ${kvconfig} "$directory/myBase16Kvantum.kvconfig"
      cp ${svg} "$directory/myBase16Kvantum.svg"
    '';
in {
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
      # General = {
      #   theme = lib.mkForce "myBase16Kvantum";
      # };
    };
    themes = with pkgs; [
      myKvantumPackage
      commonality-base16
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

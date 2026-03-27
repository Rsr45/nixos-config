{ pkgs, inputs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  stylix.targets.gtk.enable = false;
  stylix.targets.qt.enable = false;
  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/bright.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Classic";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      sansSerif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      monospace = {
        package = pkgs.geist-font;
        name = "Geist Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        desktop = 11;
        popups = 11;
        applications = 11;
        terminal = 11;
      };
    };
  };
}

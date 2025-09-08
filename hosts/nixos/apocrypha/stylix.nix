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
      # serif = {
      #   package = pkgs.inter;
      #   name = "Inter";
      # };
      #
      # sansSerif = {
      #   package = pkgs.inter;
      #   name = "Inter";
      # };
      #
      # monospace = {
      #   package = pkgs.nerd-fonts.iosevka;
      #   name = "Iosevka Nerd Font";
      # };
      #
      # emoji = {
      #   package = pkgs.noto-fonts-emoji;
      #   name = "Noto Color Emoji";
      # };

      sizes = {
        desktop = 14;
        popups = 14;
        applications = 14;
        terminal = 14;
      };
    };
  };
}

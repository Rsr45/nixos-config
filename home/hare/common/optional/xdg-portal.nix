{
  pkgs,
  lib,
  ...
}: {
  xdg.portal = {
    enable = lib.mkForce true;
    extraPortals = lib.mkForce [
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-hyprland
    ];
    config = {
      common = {
        default = [
          "hyprland"
          "kde"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [
          "kde"
        ];
      };
    };
  };
  # xdg.configFile."xdg-desktop-portal-termfilechooser" = {
  #   source = ./termfilechooser;
  #   recursive = true;
  # };
}

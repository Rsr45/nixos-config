{
  pkgs,
  lib,
  ...
}: {
  xdg.portal = {
    enable = lib.mkForce true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-hyprland
    ];
    config = {
      common = {
        default = [
          "hyprland"
          "kde"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [
          "kde"
          "gtk"
        ];
      };
    };
  };
  # xdg.configFile."xdg-desktop-portal-termfilechooser" = {
  #   source = ./termfilechooser;
  #   recursive = true;
  # };
}

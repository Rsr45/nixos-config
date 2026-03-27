{ pkgs, lib, ... }:
{
  xdg.portal = {
    enable = lib.mkForce true;
    extraPortals = lib.mkForce [
      pkgs.xdg-desktop-portal-termfilechooser
      pkgs.lxqt.xdg-desktop-portal-lxqt
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
    config = {
      common = {
        default = [
          "kde"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [
          "termfilechooser"
        ];
      };
    };
  };
  xdg.configFile."xdg-desktop-portal-termfilechooser" = {
    source = ./termfilechooser;
    recursive = true;
  };
}

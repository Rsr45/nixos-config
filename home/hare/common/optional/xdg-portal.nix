{
  pkgs,
  lib,
  ...
}: {
  xdg.portal = {
    enable = true;
#     extraPortals = [
#       pkgs.kdePackages.xdg-desktop-portal-kde
#     ];
#     config = {
#       common = {
#         # default = [
#         #   "hyprland"
#         #   "kde"
#         # ];
#         "org.freedesktop.impl.portal.FileChooser" = [
#           "kde"
#         ];
# "org.freedesktop.impl.portal.Secret" = "kwallet";
#       };
#     };
  };
  # xdg.configFile."xdg-desktop-portal-termfilechooser" = {
  #   source = ./termfilechooser;
  #   recursive = true;
  # };
}

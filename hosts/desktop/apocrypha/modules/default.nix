{pkgs, ...}: {
  home.packages = with pkgs; [
    waypaper
    hyprpaper
  ];
}

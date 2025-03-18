{pkgs, ...}: {
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 24;
  };
  gtk.cursorTheme = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 24;
  };
}

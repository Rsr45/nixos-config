{ pkgs, lib, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = lib.mkDefault pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
    size = 24;
  };
  gtk.cursorTheme = {
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
    size = 24;
  };
}

{ pkgs, lib, ... }:
let
  package = pkgs.capitaine-cursors-themed;
  name = "Capitaine Cursors (Gruvbox)";
in
{
  home.pointerCursor = {
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = name;
    };
    hyprcursor = {
      enable = true;
      size = 24;
    };
    sway.enable = true;
    dotIcons.enable = true;
    package = package;
    name = name;
    size = 24;
  };

  gtk.cursorTheme = {
    package = package;
    name = name;
    size = 24;
  };
}

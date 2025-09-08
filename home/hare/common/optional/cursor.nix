{ pkgs, lib, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "Capitaine Cursors (Gruvbox)";
    };
    hyprcursor = {
      enable = true;
      size = 24;
    };
    sway.enable = true;
    dotIcons.enable = true;
    package = lib.mkDefault pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
    size = 24;
  };
  gtk.cursorTheme = {
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
    size = 24;
  };
  xsession.enable = true;
  xsession.pointerCursor = {
    package = lib.mkDefault pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
    size = 24;
    defaultCursor = "Capitaine Cursors (Gruvbox)";
  };
}

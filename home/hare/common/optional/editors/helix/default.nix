{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    # package = pkgs.evil-helix;
    # settings = {
    #   editor = {
    #     color-modes = true;
    #     cursor-shape = {
    #       normal = "block";
    #       insert = "bar";
    #       select = "underline";
    #     };
    #     cursorline = true;
    #     whitespace.characters = {
    #       newline = "↴";
    #       tab = "⇥";
    #     };
    #     true-color = true;
    #     # trim-final-newlines = true;
    #     # trim-trailing-whitespace = true;
    #   };
    # };
  };
}

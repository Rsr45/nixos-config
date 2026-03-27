{ pkgs, ... }:

{
  home.packages = with pkgs; [
    emacs-gtk
    mlocate
    cmake
    graphviz
  ];
}

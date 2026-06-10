{ pkgs, inputs, ... }:

{
  imports = [
    # inputs.nix-doom-emacs-unstraightened.homeModule
  ];

  # programs.emacs.enable = true;
  # programs.emacs.package = pkgs.emacs-gtk;

  # programs.doom-emacs = {
  #   enable = true;
  #   doomDir = ./doom; # or e.g. `./doom.d` for a local configuration
  #   provideEmacs = false;
  # };

  home.packages = with pkgs; [
    # (doom-emacs {
    #   doomDir = ./doom;
    # })
    emacs-gtk
    cmake
    gcc
    libtool
    graphviz
  ];
}

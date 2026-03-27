{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # texliveSmall
    texliveMedium
    texlivePackages.latexmk
    # texliveFull
  ];
}

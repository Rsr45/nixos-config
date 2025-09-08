{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    binutils
    coreutils
    desktop-file-utils
    diffutils
    fd
    file
    findutils
    fzf
    gawk
    git
    gnugrep
    gnumake
    gnused
    gnutar
    less
    procps
    ripgrep
    sharutils
    stow
    toybox
    util-linux
    xdg-utils
    xz
  ];
}

{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    coreutils
    findutils
    binutils
    desktop-file-utils
    diffutils
    fd
    file
    fzf
    gawk
    git
    gnugrep
    gnumake
    gnused
    less
    procps
    ripgrep
    sharutils
    stow
    toybox
    util-linux
    xdg-utils

    gnutar
    xz
    p7zip
    rar
    zip
    unrar
    unzip
    bzip2
    bzip3
  ];
}

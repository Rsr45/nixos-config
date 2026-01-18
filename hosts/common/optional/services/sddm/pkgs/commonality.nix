{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "sddm-commonality";
  src = pkgs.fetchFromGitLab {
    domain = "www.opencode.net";
    owner = "phob1an";
    repo = "commonality";
    rev = "83633741baeffb40888eb083bb56d5718611e414";
    hash = "sha256-IFc1N0WDs+LW54SYggknoKLDGMk1DkwfFaj2bppZfJo=";
  };

  installPhase = ''
    mkdir -p $out
    cp -R $src/sddm/themes/Commonality/* $out/
    cd $out/
  '';
}

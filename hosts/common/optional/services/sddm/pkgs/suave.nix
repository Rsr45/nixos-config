{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "sddm-suave";
  src = pkgs.fetchFromGitLab {
    domain = "www.opencode.net";
    owner = "phob1an";
    repo = "suave";
    rev = "784659cb8d895bc88e0c9f5d5af78987fa3fe033";
    hash = "sha256-nt20e3kuU3mgvh7Ly2tofCHPtMAacoanZ0pzi7RKMqo=";
  };

  installPhase = ''
    mkdir -p $out
    cp -R $src/sddm/themes/Suave/* $out/
    cd $out/
  '';
}

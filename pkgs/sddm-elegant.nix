{pkgs}: let
  imgLink = "https://github.com/NixOS/nixos-artwork/blob/master/wallpapers/nix-wallpaper-simple-dark-gray_bottom.png";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "254cb37fd7584722d09b124f2a9b43c572fbc91a8016de6e3340bd72b924118e";
  };
in
  pkgs.stdenv.mkDerivation {
    name = "sddm-elegant";
    src = pkgs.fetchFromGitHub {
      owner = "surajmandalcell";
      repo = "Elegant-sddm";
      rev = "3102e880f46a1b72c929d13cd0a3fb64f973952a";
      sha256 = "0x5sv2l5l4ral8sk4w8aa9w1chh5zhlkq9d6f6798r8xid6iyzfa";
    };
    installPhase = ''
      mkdir -p $out
      cp -R $src/Elegant/* $out/
      cd $out/
      rm background.jpg
      cp -r ${image} $out/background.jpg
    '';
  }

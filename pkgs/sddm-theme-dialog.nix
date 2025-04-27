{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "sddm-theme-dialog";
  src = pkgs.fetchFromGitHub {
    owner = "joshuakraemer";
    repo = "sddm-theme-dialog";
    rev = "53f81e322f715d3f8e3f41c38eb3774b1be4c19b";
    sha256 = "1zf33qwkjhc6ilci4jd5ll3mkzvidgjdb1kz03mpvg0ffi3d50ma";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}

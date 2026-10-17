{
  pkgs,
  pkgsUnstable,
  ...
}: {
  environment.systemPackages = with pkgsUnstable; [
    ghostty
    perl
    perlPackages.URI
    perlPackages.GetoptLong
    dmenu

    lynx
    w3m-full
  ];
}

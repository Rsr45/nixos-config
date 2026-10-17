{
  pkgsUnstable,
  pkgs,
  ...
}: {
  programs.brave = {
    enable = true;
    package = pkgsUnstable.brave-origin;
    # extensions = [
    #   { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
    # ];
  };
}

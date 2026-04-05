{ ... }:
{
  programs.brave = {
    enable = true;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
    ];
  };
}

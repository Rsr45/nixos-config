{ ... }:
{
  programs.vivaldi = {
    enable = true;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # vimiumc
    ];
  };
}

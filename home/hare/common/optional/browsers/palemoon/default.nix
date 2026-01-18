{ pkgs, ... }:
{
  home.packages = with pkgs; [ palemoon-bin ];
}

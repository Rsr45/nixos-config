{ pkgs, lib, ... }:
{
  imports = [
    ./search.nix
    ./extensions.nix
  ];

  programs.firefox.profiles.default = {
    id = 0;
    isDefault = true;
    extraConfig = builtins.readFile ../../user.js + builtins.readFile ../../preferred.js;
    userChrome = builtins.readFile ./userChrome.css;
    userContent = builtins.readFile ./userContent.css;
  };
}

{ config, ... }:

let
  myAliases = {
    g = "git";
    "..." = "cd ../..";
    cd = "z";
    rebuild = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake .#apocrypha";
    reboot = "systemctl reboot";
    shutdown = "systemctl poweroff";
    logout = "hyprctl dispatch exit 1";
    yt-m = "yt-dlp --extract-audio --audio-quality 0 --add-metadata --output '${config.home.homeDirectory}/Music/Youtube/%(title).200B.%(ext)s'";
    yt-v = "yt-dlp --embed-metadata --restrict-filenames --output '${config.home.homeDirectory}/Videos/Youtube/%(title).200B.%(ext)s'";
    cs2-1080 = "gamescope -w 1080 -h 1080 -r 144 -S stretch --force-grab-cursor steam";
  };
in

{
  imports = [
    ./nu.nix
    ./fish.nix
    ./zsh.nix
    ./bash.nix
    ./starship.nix
  ];

  home = {
    shellAliases = myAliases;
    shell.enableShellIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    extraOptions = [ "--group-directories-first" ];
    icons = "auto";
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };

}

{
  # pkgs,
  # config,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';

    # preferAbbrs = true;
    # shellAbbrs = {
    #   rebuild = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake .#apocrypha";
    #   reboot = "systemctl reboot";
    #   shutdown = "systemctl poweroff";
    #   logout = "hyprctl dispatch exit 1";
    #   yt-m = "yt-dlp --extract-audio --audio-quality 0 --add-metadata --restrict-filenames --output '${config.home.homeDirectory}/Music/Youtube/%(title).200B.%(ext)s'";
    #   yt-v = "yt-dlp --embed-metadata --restrict-filenames --output '${config.home.homeDirectory}/Videos/Youtube/%(title).200B.%(ext)s'";
    #   cs2-1080 = "gamescope -w 1080 -h 1080 -r 144 -S stretch --force-grab-cursor steam";
    # };

    # plugins = [
    #   # Enable a plugin (here grc for colorized command output) from nixpkgs
    #   {
    #     name = "grc";
    #     src = pkgs.fishPlugins.grc.src;
    #   }
    #   # Manually packaging and enable a plugin
    #   {
    #     name = "z";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "jethrokuan";
    #       repo = "z";
    #       rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
    #       sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
    #     };
    #   }
    # ];
  };
}

{config, ...}: {
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
      buffer_editor = "vi";
    };

    shellAliases = {
      g = "git";
      "..." = "cd ../..";
      rebuild = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake .#apocrypha";
      reboot = "systemctl reboot";
      shutdown = "systemctl poweroff";
      logout = "hyprctl dispatch exit 1";
      yt-m = "yt-dlp --extract-audio --audio-quality 0 --add-metadata --restrict-filenames --output '${config.home.homeDirectory}/Music/Youtube/%(title).200B.%(ext)s'";
      yt-v = "yt-dlp --embed-metadata --restrict-filenames --output '${config.home.homeDirectory}/Videos/Youtube/%(title).200B.%(ext)s'";
      cs2-1080 = "gamescope -w 1080 -h 1080 -r 144 -S stretch --force-grab-cursor steam";
    };
  };
}

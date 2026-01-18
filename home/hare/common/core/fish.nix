{
  pkgs,
  config,
  ...
}:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      bind -M insert ctrl-space complete
      bind -M insert ctrl-n forward-char
      bind -M insert ctrl-p backward-char
      bind -M insert ctrl-e cancel
    '';

    preferAbbrs = true;
    shellAbbrs = {
      cd = "z";
      rebuild = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake .#apocrypha";
      # reboot = "systemctl reboot";
      # shutdown = "systemctl poweroff";
      music = "yt-dlp --extract-audio --audio-quality 0 --add-metadata --parse-metadata 'release_year:%(date)s' --parse-metadata 'album:%(album)s' --parse-metadata 'playlist_index:%(track_number)s' --embed-thumbnail --output '${config.home.homeDirectory}/Music/%(artists.0,channel,uploader)s/%(release_year)s - %(artists.0,channel,uploader)s - %(album)s/%(track_number,playlist_index)s - %(artists.0,channel,uploader)s - %(title).200B.%(ext)s'";
      # music = "yt-dlp --extract-audio --audio-quality 0 --add-metadata --parse-metadata 'playlist_index:%(track_number)s' --embed-thumbnail --output '${config.home.homeDirectory}/Music/%(uploader)s - %(title)s.%(ext)s'";
      album = "yt-dlp --extract-audio --audio-quality 0 --add-metadata --parse-metadata 'playlist_index:%(track_number)s' --embed-thumbnail --output '${config.home.homeDirectory}/Music/%(uploader)s - %(playlist)s/%(track_number,playlist_index)s - %(title)s.%(ext)s'";
      playlist = "yt-dlp --extract-audio --audio-quality 0 --add-metadata 
      --parse-metadata 'playlist_index:%(track_number)s'
      --parse-metadata 'artist:%(artist)s'
      --parse-metadata 'album_artist:%(albumartist)s'
      --parse-metadata 'artist:%(artist)s'
      --embed-thumbnail --output
      '${config.home.homeDirectory}/Music/Mixes/%(playlist)s/%(playlist_index)s
      - %(title)s.%(ext)s'";
      video = "yt-dlp --embed-metadata --output '${config.home.homeDirectory}/Videos/Youtube/%(title).200B.%(ext)s'";
      cs2-1080 = "gamescope -w 1080 -h 1080 -r 144 -S stretch --force-grab-cursor steam";
    };

    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      # Manually packaging and enable a plugin
      # {
      #   name = "z";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "jethrokuan";
      #     repo = "z";
      #     rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
      #     sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
      #   };
      # }
    ];
  };

  home.packages = with pkgs; [
    grc
  ];
}

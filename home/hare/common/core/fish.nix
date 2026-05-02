{
  pkgs,
  config,
  ...
}:
{
  programs = {
    starship.enableFishIntegration = false;
    carapace.enableFishIntegration = false;
    zoxide.enableFishIntegration = true;
    eza.enableFishIntegration = true;
    kitty.shellIntegration.enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set -g fish_transient_prompt 1
    '';

    # bind -M insert ctrl-space complete
    # bind -M insert ctrl-n forward-char
    # bind -M insert ctrl-p backward-char
    # bind -M insert ctrl-e cancel

    preferAbbrs = true;
    shellAbbrs = {
      cd = "z";
      cdi = "zi";
      ci = "zi";
      v = "~/scripts/view.sh";
      view = "~/scripts/view.sh";
      e = "nvim";
      edit = "nvim";
      y = "yazi";
      doom = "~/doom-emacs/bin/doom";
      rebuild-impure = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake .#apocrypha";
      rebuild = "sudo nixos-rebuild switch --show-trace --flake .#apocrypha";
      cs2-1080 = "gamescope -w 1080 -h 1080 -r 144 -S stretch --force-grab-cursor steam";

      mus = "yt-dlp -x --audio-quality 0 --embed-thumbnail --convert-thumbnails png --add-metadata --parse-metadata \"playlist_index:%(track_number)s\" -o \"${config.xdg.userDirs.music}/%(artists,uploader,channel)s/%(release_date>%Y,upload_date>%Y|Unknown)s_%(artists,uploader,channel)s_%(album|Unknown)s/%(track_number,playlist_index|NA)s_%(artists,uploader,channel)s_%(title).200B.%(ext)s\" --restrict-filenames --trim-filenames \"182\"";

      muscr = "yt-dlp -x --audio-quality 0 --embed-thumbnail --convert-thumbnails png --ppa \"ThumbnailsConvertor:-qmin 1 -q:v 1 -vf crop=\\\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\\\"\" --add-metadata --parse-metadata \"playlist_index:%(track_number)s\" -o \"${config.xdg.userDirs.music}/%(artists,uploader,channel)s/%(release_date>%Y,upload_date>%Y|Unknown)s_%(artists,uploader,channel)s_%(album|Unknown)s/%(track_number,playlist_index|NA)s_%(artists,uploader,channel)s_%(title).200B.%(ext)s\" --restrict-filenames --trim-filenames \"182\"";

      music = "yt-dlp -x --audio-quality 0 --embed-thumbnail --convert-thumbnails png --ppa \"ThumbnailsConvertor:-vf crop=\\\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\\\"\" --add-metadata --parse-metadata 'playlist_index:%(track_number)s' --output '${config.home.homeDirectory}/Music/%(artists,uploader,channel)s/%(release_date>%Y,upload_date>%Y|Unknown)s - %(artists,uploader,channel)s - %(album|Unknown)s/%(track_number,playlist_index|01)s - %(artists,uploader,channel)s - %(title).200B.%(ext)s'";
      music-wide = "yt-dlp -x --audio-quality 0 --embed-thumbnail --add-metadata --parse-metadata 'playlist_index:%(track_number)s' --output '${config.home.homeDirectory}/Music/%(artists,uploader,channel)s/%(release_date>%Y,upload_date>%Y|Unknown)s - %(artists,uploader,channel)s - %(album|Unknown)s/%(track_number,playlist_index|01)s - %(artists,uploader,channel)s - %(title).200B.%(ext)s'";
      album = "yt-dlp -x --audio-quality 0 --embed-thumbnail --add-metadata --parse-metadata 'playlist_index:%(track_number)s' --output '${config.home.homeDirectory}/Music/%(uploader)s - %(playlist)s/%(track_number,playlist_index)s - %(title).200B.%(ext)s'";
      playlist = "yt-dlp -x --audio-quality 0 --embed-thumbnail --add-metadata --parse-metadata 'playlist_index:%(track_number)s' --output '${config.home.homeDirectory}/Music/Mixes/%(playlist)s/%(playlist_index)s - %(title).200B.%(ext)s'";
      video = "yt-dlp --embed-metadata --output '${config.xdg.userDirs.videos}/Youtube/%(title).200B.%(ext)s'";
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

{config, ...}: let
  songDirectory = "\"${config.xdg.userDirs.music}/%(artist,uploader,channel,creator)s/%(release_date>%Y,upload_date>%Y|NA)s - %(album,series|Unknown)s - %(artist,uploader,channel,creator)s/%(track_number,playlist_index|01)s - %(artists,uploader,channel)s - %(title).200B.%(ext)s\"";
  net = "'${config.xdg.userDirs.extraConfig.NET}/%(upload_date)sT000000--%(id)s__%(uploader_id)s.%(ext)s'";

  # appendifjpg=-qmin 1 -q:v 1
in {
  home.shellAliases = {
    cd = "z";
    cdi = "zi";
    ci = "zi";
    v = "~/scripts/view.sh";
    view = "~/scripts/view.sh";
    ls = "eza --icons never";
    lsa = "eza --icons never --all";
    ll = "eza -l --git --git-repos-no-status --all --smart-group --show-symlinks --mounts --blocksize --header --binary --reverse --modified --created --hyperlink --icons never";
    lla = "eza -l --git --git-repos-no-status --all --smart-group --show-symlinks --mounts --blocksize --header --binary --reverse --modified --created --hyperlink --icons never --all";

    e = "${config.home.sessionVariables.EDITOR}";
    edit = "${config.home.sessionVariables.EDITOR}";
    doom = "${config.xdg.configHome}/emacs/bin/doom";
    rebuild-impure = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake";
    rebuild = "sudo nixos-rebuild switch --show-trace --flake";

    musicCrop = "yt-dlp -x --audio-quality 0 --embed-thumbnail --convert-thumbnails png --ppa \"ThumbnailsConvertor:-vf crop=\\\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\\\"\" --add-metadata --parse-metadata \"playlist_index:%(track_number)s\" -o ${songDirectory} --trim-filenames \"180\"";
    music = "yt-dlp -x --audio-quality 0 --embed-thumbnail --add-metadata --parse-metadata \"playlist_index:%(track_number)s\" -o ${songDirectory} --trim-filenames \"180\"";
    vid = "yt-dlp --embed-metadata -S 'vcodec:av01' -o ${net} --trim-filenames '180'";

    cs2-1080 = "gamescope -w 1080 -h 1080 -r 144 -S stretch --force-grab-cursor steam";
  };
}

{config, ...}: let
  # songDirectory = "\"${config.xdg.userDirs.music}/%(artist,uploader,channel,creator)s/%(release_date>%Y,upload_date>%Y|NA)s - %(album,series|Unknown)s - %(artist,uploader,channel,creator)s/%(track_number,playlist_index|01)s - %(artists,uploader,channel)s - %(title).200B.%(ext)s\"";
  # song = "'${config.xdg.userDirs.music}/%(fn_album&@@{}|)s%(fn_artist&=={}|)s--%(track_number,playlist_index&{}-|)s%(title)s%(release_date>%Y,upload_date>%Y&__{}|)s.%(ext)s'";
  song = "'${config.xdg.userDirs.music}/%(fn_artist&=={}|)s%(fn_album&@@{}|)s--%(playlist_index&{:02d}-|)s%(fn_title)s__%(fn_date)s.%(ext)s'";
  net = "'${config.xdg.userDirs.videos}/__clearnet/%(upload_date,release_date&@@{}|)s%(fn_uploader&=={}|)s%(id&--{}|)s__%(resolution)s.%(ext)s'";
  dedupConsecutive = "\"([^,]+)(?:,\\s*\\1)+\" \"\\1\"";
  removeSpace = "\"\\s+\" \"\"";
  replaceSpaceToDash = "\"\\s+\" \"-\"";
  replaceSpaceToUnderScore = "\"\\s+\" \"_\"";
  replaceSpaceToEq = "\"\\s+\" \"=\"";
  replaceSpaceToAt = "\"\\s+\" \"@\"";
  replaceCommaToEq = "\"[,，]\" \"=\"";
  replaceCommaToHash = "\",\" \"#\"";
  artistSepSemiC = "\"[,，]\" \";\"";
  sanitize = "\"[@%\\\\#₺|_*\\\"':;/\\\!?&.\\[\\]<>\\-+{}()]\" \"\"";
  sanitizeWcomma = "\"[@%\\\\#₺|_*\\\"':;/\\\!?&.,，\\[\\]<>\\-+{}()]\" \"\"";
  fnArtist = "--parse-metadata \"%(artist,artists,uploader,channel,creator|)s:%(fn_artist)s\" --replace-in-metadata \"fn_artist\" ${dedupConsecutive} --replace-in-metadata \"fn_artist\" ${removeSpace} --replace-in-metadata \"fn_artist\" ${sanitize} --replace-in-metadata \"fn_artist\" ${replaceCommaToEq}";
  fnAlbum = "--parse-metadata \"%(album|)s:%(fn_album)s\" --replace-in-metadata \"fn_album\" ${sanitizeWcomma} --replace-in-metadata \"fn_album\" ${replaceSpaceToAt}";
  titleMusicVid1 = "--replace-in-metadata 'title' '(?i)\\s*\\(official music video\\)' ''";
  titleMusicVid2 = "--replace-in-metadata 'title' '(?i)\\s*\\(official video\\)' ''";
  titleMusicVid3 = "--replace-in-metadata 'title' '(?i)\\s*\\(official\\)' ''";
  titleMusicVid = "${titleMusicVid1} ${titleMusicVid2} ${titleMusicVid3}";
  fnTitle = "--parse-metadata \"%(track,title|)s:%(fn_title)s\" --replace-in-metadata \"fn_title\" ${sanitizeWcomma}  --replace-in-metadata \"fn_title\" ${replaceSpaceToDash}";
  artistDeduped = "--replace-in-metadata \"artist\" ${dedupConsecutive}";
  artistRemoveTopic = "--parse-metadata \"%(artists,artist,creators,uploader,channel,creator|)l:^(?P<uploader>.*?)(?:(?= - Topic)|\\$)\"";
  artistSepChanged = "--replace-in-metadata \"artist\" ${artistSepSemiC}";
  cropThumbnail = "--convert-thumbnails png --ppa \"ThumbnailsConvertor:-vf crop=\\\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\\\"\"";
  albumArtist = "--parse-metadata \"%(playlist_uploader,artist|)s:^(?P<first_artist>.*?)(?:(?=,\\s+)|\\$)\" --parse-metadata \"%(album_artist,first_artist|)s:%(album_artist)s\"";
  trackNumber = "--parse-metadata \"%(track_number,playlist_index|)s:%(track_number)s\"";
  fnDate = "--parse-metadata \"%(release_date>%Y,upload_date>%Y)s:%(fn_date)s\"";
  metadata = "--parse-metadata \":(?P<meta_>)\" --parse-metadata \"%(release_date>%Y,upload_date>%Y)s:%(meta_date)s\" --parse-metadata \"title:%(meta_title)s\" --parse-metadata \"album:%(meta_album)s\" --parse-metadata \"track_number:%(meta_track)s\" --parse-metadata \"artist:%(meta_artist)s\" --parse-metadata \"meta_date:%(meta_date)s\"";
  # --- Video Related
  fnUploader = "--parse-metadata \"%(artist,artists,uploader_id,uploader,channel,creator|)s:%(fn_uploader)s\" --replace-in-metadata \"fn_uploader\" ${removeSpace} --replace-in-metadata \"fn_uploader\" ${sanitizeWcomma}";
  metadataVid = "--parse-metadata \":(?P<meta_>)\" --parse-metadata \"%(release_date,upload_date)s:%(meta_date)s\" --parse-metadata \"title:%(meta_title)s\" --parse-metadata \"%(artists,artist,uploader_id,uploader,channel,creator)s:%(meta_artist)s\" --parse-metadata \"meta_date:%(meta_date)s\"";
in {
  home.shellAliases = {
    disk = "dysk -u binary";
    cd = "z";
    cdi = "zi";
    ci = "zi";
    ls = "eza --icons never";
    lsa = "eza --icons never --all";
    ll = "eza -l --git --git-repos-no-status --smart-group --show-symlinks --mounts --blocksize --header --binary --reverse --modified --created --hyperlink --icons never";
    lla = "eza -l --git --git-repos-no-status --smart-group --show-symlinks --mounts --blocksize --header --binary --reverse --modified --created --hyperlink --icons never --all";

    e = "${config.home.sessionVariables.EDITOR}";
    edit = "${config.home.sessionVariables.EDITOR}";
    emacs = "emacs --init-directory ~/.config/emacs/";
    doom = "${config.xdg.configHome}/emacs/bin/doom";
    rebuild-impure = "sudo nixos-rebuild switch --show-trace --option eval-cache false --impure --flake";
    rebuild = "sudo nixos-rebuild switch --show-trace --flake";

    song = "yt-dlp --trim-filenames '240' -x -S 'res:720,vcodec:av01,acodec:opus,vext:mkv,aext:opus' --embed-chapters --embed-metadata --embed-thumbnail ${cropThumbnail} ${artistRemoveTopic} ${artistDeduped} ${fnArtist} ${fnAlbum} ${titleMusicVid} ${fnTitle} ${trackNumber} ${fnDate} ${artistSepChanged} ${metadata} -o ${song} --exec 'after_move:lowercase-filenames %(filepath)q'";
    songNoCrop = "yt-dlp --trim-filenames '240' -x -S 'res:720,vcodec:av01,acodec:opus,vext:mkv,aext:opus' --embed-chapters --embed-metadata --embed-thumbnail ${artistRemoveTopic} ${artistDeduped} ${fnArtist} ${fnAlbum} ${titleMusicVid} ${fnTitle} ${trackNumber} ${fnDate} ${artistSepChanged} ${metadata} -o ${song} --exec 'after_move:lowercase-filenames %(filepath)q'";

    vid = "yt-dlp --trim-filenames '240' -S 'res:720,vcodec:av01,acodec:opus,vext:mkv,aext:opus' --write-description --embed-chapters --embed-metadata --embed-thumbnail ${artistRemoveTopic} ${titleMusicVid} --sponsorblock-mark 'all' ${fnUploader} ${metadataVid} -o ${net} --exec 'after_move:lowercase-filenames %(filepath)q'";

    cs2-1080 = "gamescope -w 1080 -h 1080 -r 144 -S stretch --force-grab-cursor steam";
  };
}

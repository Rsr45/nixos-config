{ pkgs, ... }:
let
  # FIXME(xdg): That should use config options and just reference whatever is configured as the default
  browser = [
    "librewolf.desktop"
    "vivaldi.desktop"
  ];
  editor = [
    "neovide.desktop"
    "nixCats.desktop"
    "helix.desktop"
  ];
  video = [
    "vlc.desktop"
    "mpv.desktop"
  ];
  audio = [
    "audacious.desktop"
    "org.strawberrymusicplayer.strawberry.desktop"
  ];
  image = [
    "vimiv.desktop"
    "feh.desktop"
  ];
  ebook = [ "calibre-ebook-viewer.desktop" ];
  archive = [
    "xarchiver.desktop"
    "peazip.desktop"
    "peazip-extract.desktop"
    "peazip-add-to-archive.desktop"
  ];
  filemanager = [
    "pcmanfm-qt.desktop"
    "doublecmd.desktop"
  ];
  writer = [
    "onlyoffice-desktopeditors.desktop"
    "libreoffice-writer.desktop"
  ];
  spreadsheet = [
    "onlyoffice-desktopeditors.desktop"
    "libreoffice-calc.desktop"
  ];
  slidedeck = [
    "onlyoffice-desktopeditors.desktop"
    "libreoffice-impress.desktop"
  ];
  math = [
    "onlyoffice-desktopeditors.desktop"
    "libreoffice-math.desktop"
  ];
  base = [
    "onlyoffice-desktopeditors.desktop"
    "libreoffice-base.desktop"
  ];
  draw = [
    "onlyoffice-desktopeditors.desktop"
    "libreoffice-draw.desktop"
  ];
  pdf = [ "org.pwmt.zathura.desktop" ];
  # Extensive list of associations here:
  # https://github.com/iggut/GamiNiX/blob/8070528de419703e13b4d234ef39f05966a7fafb/system/desktop/home-main.nix#L77
  associations = {

    "inode/directory" = filemanager;
    "application/x-gnome-saved-search" = filemanager;

    "application/zip" = archive;
    "application/vnd.rar" = archive;
    "application/x-7z-compressed" = archive;
    "application/x-tar" = archive;
    "application/x-xz-compressed-tar" = archive;

    "text/*" = editor;
    "text/plain" = editor;
    "x-scheme-handler/terminal" = editor;

    "application/x-zerosize" = editor; # empty files
    "application/x-shellscript" = editor;
    "application/x-perl" = editor;
    "application/json" = editor;

    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    "application/pdf" = pdf;

    "application/mxf" = video;
    "application/sdp" = video;
    "application/smil" = video;
    "application/streamingmedia" = video;
    "application/vnd.apple.mpegurl" = video;
    "application/vnd.ms-asf" = video;
    "application/vnd.rn-realmedia" = video;
    "application/vnd.rn-realmedia-vbr" = video;
    "application/x-cue" = video;
    "application/x-extension-m4a" = video;
    "application/x-extension-mp4" = video;
    "application/x-matroska" = video;
    "application/x-mpegurl" = video;
    "application/x-ogm" = video;
    "application/x-ogm-video" = video;
    "application/x-shorten" = video;
    "application/x-smil" = video;
    "application/x-streamingmedia" = video;

    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;

    "x-scheme-handler/sgnl" = "signal-desktop.desktop";

    "audio/*" = audio;
    "video/*" = video;
    "image/*" = image;
    "image/jpeg" = image;
    "image/png" = image;
    "image/gif" = image;
    "image/webp" = image;

    "text/csv" = spreadsheet;
    "application/vnd.ms-excel" = spreadsheet;
    "application/vnd.ms-powerpoint" = slidedeck;
    "application/vnd.ms-word" = writer;
    "application/vnd.oasis.opendocument.database" = base;
    "application/vnd.oasis.opendocument.formula" = math;
    "application/vnd.oasis.opendocument.graphics" = draw;
    "application/vnd.oasis.opendocument.graphics-template" = draw;
    "application/vnd.oasis.opendocument.presentation" = slidedeck;
    "application/vnd.oasis.opendocument.presentation-template" = slidedeck;
    "application/vnd.oasis.opendocument.spreadsheet" = spreadsheet;
    "application/vnd.oasis.opendocument.spreadsheet-template" = spreadsheet;
    "application/vnd.oasis.opendocument.text" = writer;
    "application/vnd.oasis.opendocument.text-master" = writer;
    "application/vnd.oasis.opendocument.text-template" = writer;
    "application/vnd.oasis.opendocument.text-web" = writer;
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" = slidedeck;
    "application/vnd.openxmlformats-officedocument.presentationml.template" = slidedeck;
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = spreadsheet;
    "application/vnd.openxmlformats-officedocument.spreadsheetml.template" = spreadsheet;
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = writer;
    "application/vnd.openxmlformats-officedocument.wordprocessingml.template" = writer;
    "application/vnd.stardivision.calc" = spreadsheet;
    "application/vnd.stardivision.draw" = draw;
    "application/vnd.stardivision.impress" = slidedeck;
    "application/vnd.stardivision.math" = math;
    "application/vnd.stardivision.writer" = writer;
    "application/vnd.sun.xml.base" = base;
    "application/vnd.sun.xml.calc" = spreadsheet;
    "application/vnd.sun.xml.calc.template" = spreadsheet;
    "application/vnd.sun.xml.draw" = draw;
    "application/vnd.sun.xml.draw.template" = draw;
    "application/vnd.sun.xml.impress" = slidedeck;
    "application/vnd.sun.xml.impress.template" = slidedeck;
    "application/vnd.sun.xml.math" = math;
    "application/vnd.sun.xml.writer" = writer;
    "application/vnd.sun.xml.writer.global" = writer;
    "application/vnd.sun.xml.writer.template" = writer;
    "application/vnd.wordperfect" = writer;

    "application/x-mobipocket-ebook" = ebook;
    "application/vnd.comicbook+zip" = ebook;
    "application/epub+zip" = ebook;
  };
  removals = {
    # Calibre steals odt association from libreoffic so need to remove
    "application/vnd.oasis.opendocument.text" = [
      "calibre-ebook-viewer.desktop"
      "calibre-ebook-edit.desktop"
      "calibre-gui.desktop"
    ];
  };
in
{
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = associations;
  xdg.mimeApps.associations.removed = removals;
  xdg.mimeApps.associations.added = associations;

  home.packages = builtins.attrValues {
    inherit (pkgs)
      handlr-regex # better xdg-open for desktop apps says mr.emergentmind
      ;
  };
}

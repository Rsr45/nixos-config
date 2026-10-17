{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./polkit-auth-gnome.nix
    ./wallpaper-picker-xorg.nix
    ./wallpaper-picker-vicinae.nix
    ./screenshot-ocr.nix
    ./list-duplicates.nix
    ./fzf-trash.nix
    ./duplicate-images-after-comp.nix
    ./compress-ss.nix
    ./vidthumb.nix

    # ytdlp and such filename utils
    ./lowercase-filenames.nix
    # denote.el scripts so we do not need to use emacs fuck emacs
    ./denote.nix
    ./denote-rename-identifier.nix
    ./denote-rename-keywords.nix
    ./denote-rename-signature.nix
    ./denote-rename-title.nix
    ./denote-sanitize-keywords.nix
    ./denote-sanitize-signature.nix
    ./denote-sanitize-title.nix

    # de utils
    ./ss-xorg.nix
    ./bookmarks.nix
  ];

  # home.packages = with pkgs; [
  # ];
}

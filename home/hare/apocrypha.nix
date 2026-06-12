{ ... }:
{
  imports = [
    # ========== X ==========
    # Never to be removed at all must have ...
    common/core
    common/optional/xdg-portal.nix

    # ========== X ==========
    # WM/DE homemanager eq
    common/optional/hyprland.nix
    common/optional/sway.nix

    # ========== X ==========
    # Sys ui themeing/qt/gtk etc
    common/core/qt.nix
    common/core/kvantum.nix
    common/optional/gtk.nix

    common/optional/wallust.nix
    common/optional/xdg-mime.nix
    common/optional/stylix.nix
    common/optional/font.nix
    common/optional/hyprpaper.nix
    common/optional/hyprlock.nix
    common/optional/hyprpicker.nix
    common/optional/waybar.nix
    common/optional/keepassxc.nix
    common/optional/mail.nix
    common/optional/thunderbird.nix
    common/optional/quickshell.nix
    common/optional/noctalia.nix
    # common/optional/eww
    common/optional/wlr-which.nix
    common/optional/kdeconnect.nix

    # ========== X ==========
    #
    common/optional/tmux.nix
    common/optional/foot.nix
    common/optional/yazi.nix
    common/optional/yt-dlp.nix
    common/optional/fastfetch.nix
    common/optional/sioyek.nix
    common/optional/alacritty.nix

    common/optional/typst.nix
    common/optional/pandoc.nix
    ## ========= Editors =========
    # common/optional/editors/nixvim
    # common/optional/editors/nixCats # formatters need to be in path or is it only nixfmt??
    # common/optional/editors/nixvim-standalone # lsp_s not getting installed?
    common/optional/editors/nvf
    common/optional/editors/helix # cool shit very nice but i dont like not being ablet to %%%
    common/optional/editors/emacs # ehh mehh i mean the only reason i would use it is denote and roam in which denote should be replicatable in vim as well so so 
    common/optional/editors/zed.nix # cool but i hate json why why why ohh well when i conf it to my vim binds it will be better than using evilmacs

    common/optional/direnv.nix
    # ========== X ==========
    #
    common/optional/mpd.nix
    common/optional/spotify.nix
    # common/optional/strawberry.nix
    common/optional/audacious.nix
    common/optional/nixcord.nix

    common/optional/inkscape.nix

    # ========== X ==========
    #
    # common/optional/browsers/firefox
    common/optional/browsers/floorp
    common/optional/browsers/zen.nix
    common/optional/browsers/helium.nix
    # common/optional/browsers/librewolf
    # common/optional/browsers/qutebrowser.nix
    # common/optional/browsers/brave.nix
    # common/optional/browsers/vivaldi.nix
    # common/optional/browsers/chrome.nix
    common/optional/libreoffice.nix

    # ========== X ==========
    ## organize them to probably
    common/optional/bemenu.nix
    common/optional/wlogout.nix
    common/optional/packages/default.nix
  ];
}

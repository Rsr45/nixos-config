{ ... }:
{
  imports = [
    # ========== X ==========
    #
    common/core
    common/optional/xdg-portal.nix

    # ========== X ==========
    #
    common/core/qt.nix
    common/core/kvantum.nix
    common/optional/gtk.nix
    common/optional/matugen/matugen.nix
    common/optional/wallust.nix
    common/optional/hyprland.nix
    # common/optional/sway.nix
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
    common/optional/neomutt.nix
    common/optional/dunst.nix
    common/optional/quickshell.nix
    common/optional/wlr-which.nix

    # ========== X ==========
    #
    common/optional/tmux.nix
    common/optional/yazi.nix
    common/optional/vimiv.nix
    common/optional/yt-dlp.nix
    common/optional/fastfetch.nix
    common/optional/zathura.nix

    common/optional/typst.nix
    common/optional/pandoc.nix
    common/optional/editors/nixvim
    # common/optional/editors/nvf
    common/optional/editors/emacs

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
    common/optional/browsers/brave.nix
    common/optional/browsers/vivaldi.nix
    common/optional/libreoffice.nix

    # ========== X ==========
    ## organize them to probably
    common/optional/bemenu.nix
    common/optional/wlogout.nix
    common/optional/packages/default.nix
  ];
}

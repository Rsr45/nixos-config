{ ... }:
{
  imports = [
    # ========== X ==========
    #
    common/core
    common/optional/mail.nix

    # ========== X ==========
    #
    common/core/qt.nix
    common/optional/gtk.nix
    common/optional/matugen/matugen.nix
    common/optional/wallust.nix
    common/optional/hyprland.nix
    # common/optional/sway.nix
    common/optional/xdg.nix
    common/optional/stylix.nix
    common/optional/font.nix
    common/optional/hyprpaper.nix
    common/optional/hyprlock.nix
    common/optional/hyprpicker.nix
    common/optional/waybar.nix
    # common/optional/swaync.nix
    common/optional/dunst.nix
    common/optional/keepassxc.nix
    common/optional/thunderbird.nix

    # ========== X ==========
    #
    common/optional/alacritty.nix
    common/optional/kitty.nix
    common/optional/tmux.nix
    common/optional/vifm.nix
    common/optional/yazi.nix
    common/optional/vimiv.nix
    common/optional/yt-dlp.nix
    common/optional/fastfetch.nix
    common/optional/zathura.nix

    common/optional/typst.nix
    common/optional/pandoc.nix

    common/optional/neovim.nix

    # ========== X ==========
    #
    common/optional/mpd.nix
    common/optional/spotify.nix
    common/optional/strawberry.nix
    common/optional/audacious.nix
    common/optional/nixcord.nix


    common/optional/koreader.nix

    # ========== X ==========
    #
    common/optional/browsers/floorp.nix
    # common/optional/browsers/schizofox.nix
    common/optional/browsers/librewolf.nix
    # common/optional/editors/nvf.nix
    # common/optional/editors/nixvim.nix
    common/optional/editors/zed.nix
    common/optional/editors/helix.nix
    common/optional/libreoffice.nix

    # ========== X ==========
    ## organize them to probably
    common/optional/shell/default.nix
    common/optional/widgets/default.nix
    common/optional/packages/default.nix
  ];
}

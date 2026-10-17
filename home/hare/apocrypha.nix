{ pkgs, ... }: {
  imports = [
    # ========== X ==========
    # Never to be removed at all must have ...
    common/core
    common/optional/xdg-mime.nix
    # ========== X ==========
    # WM/DE homemanager eq
    common/optional/xdg-portal.nix
    common/optional/gtk.nix
    # common/optional/sway.nix
    common/optional/hyprland.nix
    # common/optional/i3status-rs.nix
    common/optional/quickshell.nix
    common/optional/dunst.nix
    common/optional/wallust.nix

    common/optional/stylix.nix
    common/optional/font.nix
    common/optional/mail.nix
    common/optional/thunderbird.nix
    common/optional/kdeconnect.nix

    # ========== X ==========
    #
    common/optional/flatpak
    # common/optional/browsers/helium.nix

    common/optional/mpd.nix
    common/optional/tmux.nix
    common/optional/foot.nix
    common/optional/alacritty.nix
    common/optional/fastfetch.nix
    common/optional/sioyek.nix

    common/optional/typst.nix
    common/optional/pandoc.nix
    ## ========= Editors =========
    common/optional/editors/nixCats # formatters need to be in path or is it only nixfmt??
    common/optional/editors/helix # cool shit very nice but i dont like not being ablet to %%%
    # common/optional/editors/nvf
    common/optional/editors/emacs # ehh mehh i mean the only reason i would use it is denote and roam in which denote should be replicatable in vim as well so so

    common/optional/direnv.nix
    # ========== X ==========
    #
    common/optional/libreoffice.nix
    common/optional/inkscape.nix
    common/optional/browsers/firefox

    # ========== X ==========
    ## organize them to probably
    common/optional/packages/default.nix
  ];
}

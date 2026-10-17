{
  pkgs,
  lib,
  inputs,
  ...
}: {
  xdg = {
    portal = {
      enable = lib.mkForce true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
        # kdePackages.xdg-desktop-portal-kde
        # xdg-desktop-portal-termfilechooser
      ];

      config = {
        # to find XDG files : got to the {hash} of the new version and find file named xdg-desktop*
        # .services files are located : /etc/profiles/per-user/...{user}.../share/systemd/user

        # pattern :
        # {name} -> "{name}-" -> {name}-portals.conf file

        # common -> empty -> portals.conf file
        common = {
          default = ["gtk"];
          "org.freedesktop.impl.portal.ScreenCast" = ["hyprland" "wlr"];
          "org.freedesktop.impl.portal.Screenshot" = ["hyprland" "wlr"];
          "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
          "org.freedesktop.impl.portal.Inhibit" = ["none"];

          # "org.freedesktop.impl.portal.FileChooser" = [ "kde" "gtk" ];
        };

        # wlroots -> "wlroots-" -> wlroots-portals.conf file
        wlroots = {
        };
      };
    };

    configFile = {
      "xdg-desktop-portal-termfilechooser/config" = {
        force = true;
        executable = true;
        text = ''
          [filechooser]
          cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/nnn-wrapper.sh
          default_dir=$HOME/Downloads
          create_help_file=1
          env=TERMCMD='kitty'
          env=PATH="$PATH:/run/current-system/sw/bin"
          env=NNN_PLUG="p:preview-tui;s:kdeconnect;c:autojump;d:dups;m:nmount;f:fixname"
          env=NNN_FIFO="/tmp/nnn.fifo"
          env=NNN_OPTS="He"
          open_mode=suggested
          save_mode=last
        '';
      };
    };
  };
}

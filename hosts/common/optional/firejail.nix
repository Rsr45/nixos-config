{ lib, pkgs, ... }:
{
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      firefox = {
        executable = "${lib.getBin pkgs.firefox}/bin/firefox";
        profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
        desktop = "${pkgs.firefox}/share/applications/firefox.desktop";
        extraArgs = [
          # Required for U2F USB stick
          "--ignore=private-dev"
          # Enforce dark mode
          "--env=GTK_THEME=Adwaita:dark"
          # Enable system notifications
          "--dbus-user.talk=org.freedesktop.Notifications"
        ];
      };
      # no longer works ???
      librewolf = {
        executable = "${lib.getBin pkgs.librewolf}/bin/librewolf";
        profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
        desktop = "${pkgs.librewolf}/share/applications/librewolf.desktop";
        extraArgs = [
          # Hardened Malloc Fix
          "--blacklist=/etc/ld-nix.so.preload"
          # Required for U2F USB stick
          "--ignore=private-dev"
          # Enforce dark mode
          "--env=GTK_THEME=Adwaita:dark"
          # Enable system notifications
          "--dbus-user.talk=org.freedesktop.Notifications"
        ];
      };
      floorp = {
        executable = "${lib.getBin pkgs.floorp-bin}/bin/librewolf";
        # profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
        desktop = "${pkgs.floorp-bin}/share/applications/floorp.desktop";
        extraArgs = [
          # Hardened Malloc Fix
          "--blacklist=/etc/ld-nix.so.preload"
          # Required for U2F USB stick
          "--ignore=private-dev"
          # Enforce dark mode
          "--env=GTK_THEME=Adwaita:dark"
          # Enable system notifications
          "--dbus-user.talk=org.freedesktop.Notifications"
          "--noprofile"
        ];
      };
      mpv = {
        executable = "${lib.getBin pkgs.mpv}/bin/mpv";
        profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
      };
    };
  };
  environment.etc = {
    "firejail/firefox.local".text = ''
      # Enable native notifications.
      dbus-user.talk org.freedesktop.Notifications
      # Allow inhibiting screensavers.
      dbus-user.talk org.freedesktop.ScreenSaver
      # Allow screensharing under Wayland.
      dbus-user.talk org.freedesktop.portal.Desktop
    '';

    "firejail/librewolf.local".text = ''
      # Enable native notifications.
      dbus-user.talk org.freedesktop.Notifications
      # Allow inhibiting screensavers.
      dbus-user.talk org.freedesktop.ScreenSaver
      # Allow screensharing under Wayland.
      dbus-user.talk org.freedesktop.portal.Desktop
    '';
  };
}

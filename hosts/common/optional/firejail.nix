{ lib, pkgs, ... }:
{
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      # firefox = {
      #   executable = "${pkgs.firefox}/bin/firefox";
      #   profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
      #   extraArgs = [
      #     # Required for U2F USB stick
      #     "--ignore=private-dev"
      #     # Enforce dark mode
      #     "--env=GTK_THEME=Adwaita:dark"
      #     # Enable system notifications
      #     "--dbus-user.talk=org.freedesktop.Notifications"
      #   ];
      # };
      # librewolf = {
      #   executable = "${pkgs.librewolf}/bin/librewolf";
      #   profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
      #   extraArgs = [
      #     # Required for U2F USB stick
      #     "--ignore=private-dev"
      #     # Enforce dark mode
      #     "--env=GTK_THEME=Adwaita:dark"
      #     # Enable system notifications
      #     "--dbus-user.talk=org.freedesktop.Notifications"
      #   ];
      # };
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

{ ... }:
{
  home.file = {
    ".local/share/dbus-1/services/org.freedesktop.secrets.service".text = ''
      [D-BUS Service]
      Name=org.freedesktop.secrets
      Exec=/usr/bin/keepassxc
    '';
  };
}

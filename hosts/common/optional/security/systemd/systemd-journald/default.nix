{ ... }: {
  systemd.services.systemd-journald.serviceConfig = {
    NoNewPrivileges = true;
    ProtectProc = "invisible";
    ProtectHostname = true;
    PrivateMounts = true;
  };
  services.journald = {
    storage = "volatile";
    upload.enable = false;
  };
}

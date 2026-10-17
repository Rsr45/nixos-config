{ ... }: {
  # Enable Plasma
  services = {
    desktopManager.plasma6.enable = true;

    # Default display manager for Plasma
    # displayManager.plasma-login-manager.enable = true;

    # Optionally enable xserver
    # xserver.enable = true;
  };

  systemd.user.units.plasma-ksplash.enable = false;
  systemd.units.plasma-ksplash.enable = false;
  systemd.user.services.plasma-ksplash.enable = false;
  systemd.services.plasma-ksplash.enable = false;

}

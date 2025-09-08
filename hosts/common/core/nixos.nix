{ config, lib, ... }:
{
  programs.nh = {
    enable = true;
    # clean.enable = true;
    # clean.extraArgs = "--keep-since 20d --keep 20";
    flake = "/home/user/${config.hostSpec.home}/nix-config";
  };

  #
  # ========== Localization ==========
  #
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  time.timeZone = lib.mkDefault "Europe/Istanbul";
}

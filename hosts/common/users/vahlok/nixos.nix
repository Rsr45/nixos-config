# User config applicable only to nixos
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  hostSpec = config.hostSpec;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  # Decrypt password to /run/secrets-for-users/ so it can be used to create the user
  sopsHashedPasswordFile = config.sops.secrets."passwords/${hostSpec.secondUserName}".path;
in
{
  users.groups.daily = {};
 users.mutableUsers = false;
  users.users.${hostSpec.secondUserName} = {
    home = "/home/${hostSpec.secondUserName}";
    isNormalUser = true;
    hashedPasswordFile = sopsHashedPasswordFile;

    extraGroups = lib.mkForce [
        "audio"
        "video"
        "git"
        "networkmanager"
        "scanner" # for print/scan"
        "lp" # for print/scan"
        "libvirtd"
        "adbusers"
        "mpd"
        "wireshark"
    ];
  };

  programs.git.enable = true;

}
// lib.optionalAttrs (inputs ? "home-manager") {

}

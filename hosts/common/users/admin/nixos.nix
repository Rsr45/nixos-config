# User config applicable only to nixos
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  hostSpec = config.hostSpec;
  sopsHashedPasswordFile = config.sops.secrets."passwords/admin".path;
in
  {
    users = {
      groups.admin = {};
      mutableUsers = false;
      users.${hostSpec.adminUserName} = {
        isNormalUser = true;
        description = "System administrator";
        hashedPasswordFile = sopsHashedPasswordFile;

        extraGroups = [
          "wheel"
        ];
      };
    };

    programs.git.enable = true;
}

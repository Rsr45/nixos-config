{ config, ... }: {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    # guiPasswordFile = "/etc/syncthing-gui-password"; # later
    key = config.sops.secrets.syncthing-key.path;
    cert = config.sops.secrets.syncthing-cert.path;
    user = "${config.hostSpec.username}";
    group = "users";
    configDir = "/home/${config.hostSpec.username}/.config/syncthing";
    settings = {
      devices = {
        "phone" = {
          id = "P4DV3VH-E3ZQ6VF-N3AMLCH-2XJT4RT-KIYLSY2-SFOBCZX-3ZFALNO-TM34OQI";
        };
        # "device2" = { id = "DEVICE-ID-GOES-HERE"; };
      };
      folders = {
        "Main Purpose" = {
          path = "/home/hare/shared";
          devices = [ "phone" ];
        };
        # "Example" = {
        #   path = "/home/myusername/Example";
        #   devices = [ "device1" ];
        #   # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
        #   ignorePerms = false;
        # };
        "Sensitive" = {
          path = "/home/hare/sensitive";
          devices = [
            # We trust this device to have access
            # to the decrypted contents of this folder.
            "phone"
            # We do not trust this device, but we want to have another
            # (encrypted) copy of the data for redundancy/backup/sync purposes.
            # {
            #   name = "device2";
            #   # encryptionPasswordFile is a path to a file containing the encryption password.
            #   # See below for information about managing secrets on NixOS.
            #   encryptionPasswordFile = "/run/secrets/st-sensitive-password";
            # }
          ];
        };
      };
    };
  };
}

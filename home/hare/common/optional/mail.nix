{ config,inputs,... }:
{
  ## FIXME
  imports =[
    inputs.sops-nix.homeModules.sops
  ];
sops = {
    #    defaultSopsFile = "${secretsFile}";
    # defaultSopsFile = "${sopsFolder}/${config.hostSpec.hostName}.yaml";
    validateSopsFiles = false;
    defaultSopsFile = "/home/${config.hostSpec.username}/nixos-config/secrets.yaml";

    age = {
      # automatically import host SSH keys as age keys
      # sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/home/${config.hostSpec.username}/.config/sops/age/keys.txt";
    };
    # secrets will be output to /run/secrets
    # e.g. /run/secrets/msmtp-password
    # secrets required for user creation are handled in respective ./users/<username>.nix files
    # because they will be output to /run/secrets-for-users and only when the user is assigned to a host.
  };




sops.secrets =
    {
      "mail/efe54676"= {};
      "mail/efe45676"= {};
    };

    accounts.email.accounts = {
    "efe54676@gmail.com" = {
      primary = true;
      realName = "Muhittin Efe Kaygısız";
      address = "efe54676@gmail.com";
      flavor = "gmail.com";
      # passwordCommand = "secret-tool lookup email efe54676@gmail.com";
      passwordCommand = "cat ${config.sops.secrets."mail/efe54676".path}"; # even  work??
      mbsync = {
        enable = true;
        create = "maildir";
      };
      msmtp.enable = true;
      thunderbird.enable = true;
      neomutt.enable = true;
      meli.enable = true;
    };
    "efe45676@gmail.com" = {
      realName = "Muhittin Efe Kaygısız";
      address = "efe45676@gmail.com";
      flavor = "gmail.com";
      passwordCommand = "cat ${config.sops.secrets."mail/efe45676".path}";
      # passwordCommand = "secret-tool lookup email efe45676@gmail.com";
      mbsync = {
        enable = true;
        create = "maildir";
      };
      msmtp.enable = true;
      thunderbird.enable = true;
      neomutt.enable = true;
      meli.enable = true;
    };
  };
}

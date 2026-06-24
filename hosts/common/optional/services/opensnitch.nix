{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  services.opensnitch = {
    enable = true;
    rules = {
      "000-block-domains" = {
        created = "2026-06-12T14:29:07+03:00";
        updated = "2026-06-12T14:29:07+03:00";
        name = "000-block-domains";
        description = "";
        action = "reject";
        duration = "always";
        operator = {
          operand = "lists.domains";
          data = "/home/hare/blocklists/";
          type = "lists";
          list = [ ];
          sensitive = false;
        };
        enabled = true;
        precedence = true;
        nolog = false;
      };
      chronyd = {
        created = "2026-06-12T17:55:34+03:00";
        updated = "2026-06-12T17:55:34+03:00";
        name = "chronyd";
        description = "";
        action = "allow";
        duration = "always";
        operator = {
          operand = "process.path";
          data = "${lib.getBin pkgs.chrony}/bin/chronyd";
          type = "simple";
          list = [ ];
          sensitive = false;
        };
        enabled = true;
        precedence = false;
        nolog = false;
      };
      #   systemd-resolved = {
      #     created = "2018-04-07T14:13:27.903996051+02:00";
      #     name = "systemd-resolved";
      #     enabled = true;
      #     action = "allow";
      #     duration = "always";
      #     operator = {
      #       type = "simple";
      #       sensitive = false;
      #       operand = "process.path";
      #       data = "${lib.getBin pkgs.systemd}/lib/systemd/systemd-resolved";
      #     };
      #   };
      dnscrypt-proxy = {
        created = "2026-06-12T17:56:11+03:00";
        updated = "2026-06-12T17:56:11+03:00";
        name = "dnscrypt-proxy";
        description = "";
        action = "allow";
        duration = "always";
        operator = {
          operand = "process.path";
          data = "${lib.getBin pkgs.dnscrypt-proxy}/bin/dnscrypt-proxy";
          type = "simple";
          list = [ ];
          sensitive = false;
        };
        enabled = true;
        precedence = false;
        nolog = false;
      };
      nix = {
        created = "2026-06-12T13:54:11+03:00";
        updated = "2026-06-12T13:54:11+03:00";
        name = "nix";
        description = "";
        action = "allow";
        duration = "always";
        operator = {
          operand = "process.path";
          data = "${lib.getBin pkgs.nix}/bin/nix";
          type = "simple";
          list = [ ];
          sensitive = false;
        };
        enabled = true;
        precedence = false;
        nolog = false;
      };
      syncthing = {
        created = "2026-06-12T17:54:10+03:00";
        updated = "2026-06-12T17:54:10+03:00";
        name = "syncthing";
        description = "";
        action = "allow";
        duration = "always";
        operator = {
          operand = "process.path";
          data = "${lib.getBin pkgs.syncthing}bin/syncthing";
          type = "simple";
          list = [ ];
          sensitive = false;
        };
        enabled = true;
        precedence = false;
        nolog = false;
      };
      nsncd = {
        created = "2026-06-12T14:29:07+03:00";
        updated = "2026-06-12T14:29:07+03:00";
        name = "nsncd";
        description = "";
        action = "deny";
        duration = "always";
        operator = {
          operand = "process.path";
          data = "${lib.getBin pkgs.nsncd}/bin/nsncd";
          type = "simple";
          list = [ ];
          sensitive = false;
        };
        enabled = true;
        precedence = false;
        nolog = false;
      };
      floorp = {
        created = "2026-06-12T14:29:07+03:00";
        updated = "2026-06-12T14:29:07+03:00";
        name = "floorp";
        description = "";
        action = "allow";
        duration = "always";
        operator = {
          operand = "process.path";
          data = "${lib.getBin pkgs.floorp-bin}/bin/floorp";
          type = "simple";
          list = [ ];
          sensitive = false;
        };
        enabled = true;
        precedence = false;
        nolog = false;
      };
      helium = {
        created = "2026-06-12T14:29:07+03:00";
        updated = "2026-06-12T14:29:07+03:00";
        name = "helium";
        description = "";
        action = "allow";
        duration = "always";
        operator = {
          operand = "process.path";
          data = "${lib.getBin inputs.helium-flake.packages.${pkgs.stdenv.hostPlatform.system}.helium}/bin/helium";
          type = "simple";
          list = [ ];
          sensitive = false;
        };
        enabled = true;
        precedence = false;
        nolog = false;
      };
      python313 = {
        created = "2026-06-12T14:29:07+03:00";
        updated = "2026-06-12T14:29:07+03:00";
        name = "python";
        description = "";
        action = "allow";
        duration = "always";
        operator = {
          operand = "process.path";
          data = "${lib.getBin pkgs.python313}/bin/python3.13";
          type = "simple";
          list = [ ];
          sensitive = false;
        };
        enabled = true;
        precedence = false;
        nolog = false;
      };
    };
  };

  environment.systemPackages = with pkgs; [ opensnitch-ui ];
}

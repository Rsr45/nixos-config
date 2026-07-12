{
  lib,
  inputs,
  pkgs,
config,
  ...
}:
let
  StateDirectory = "dnscrypt-proxy";
in
{
  networking = {
    nameservers = [
      "127.0.0.1"
      "::1"
    ];

    dhcpcd = {
      extraConfig = "nohook resolv.conf";
    };

    networkmanager = {
      dns = "none";
    };

    resolvconf = {
      enable = true;
      useLocalResolver = true;
    };
  };

  services.resolved.enable = lib.mkForce false;

  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      # adguardHome
      listen_addresses = [ "127.0.0.1:5335" ];

      # ipv6_servers = true;
      require_dnssec = true;
      require_nolog = true;
      # require_nofilter = false;
      odoh_servers = true;
      query_log.file = "/var/log/dnscrypt-proxy/query.log";

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";

        cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
      };

      sources.relays = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/relays.md"
          "https://download.dnscrypt.info/resolvers-list/v3/relays.md"
          "https://cdn.jsdelivr.net/gh/DNSCrypt/dnscrypt-resolvers@master/v3/relays.md"
        ];
        cache_file = "relays.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };

  # systemd.services.dnscrypt-proxy.serviceConfig.StateDirectory = StateDirectory;

    systemd.services.dnscrypt-proxy.serviceConfig = {
      StateDirectory = lib.mkForce "";
      ReadWritePaths = "/var/lib/dnscrypt-proxy";
    };

    # Make sure this directory exists so the service doesn't fail on boot
    systemd.tmpfiles.rules = [ "d /var/lib/dnscrypt-proxy 0755 root root -" ];

}

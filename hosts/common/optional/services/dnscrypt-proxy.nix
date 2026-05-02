{
  lib,
  inputs,
  pkgs,
  ...
}:
let
  StateDirectory = "dnscrypt-proxy";
  blocklist_base = builtins.readFile inputs.oisd;
  extraBlocklist = "";
  blocklist_txt = pkgs.writeText "blocklist.txt" ''
    ${extraBlocklist}
    ${blocklist_base}
  '';
in
{

  networking.nameservers = [
    "127.0.0.1"
    "::1"
  ];

  networking.resolvconf.enable = lib.mkForce false;
  networking.dhcpcd.extraConfig = "nohook resolv.conf";
  networking.networkmanager.dns = "none";
  services.resolved.enable = false;

  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      # ipv6_servers = true;
      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;
      query_log.file = "/var/log/dnscrypt-proxy/query.log";

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";

        cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
      };

      # blocked_names.blocked_names_file = blocklist_txt;

      ## fuck it it should work but somehow dnscrypt is not launching
      # local_doh = {
      #   listen_addresses = [ "127.0.0.1:3000" ];
      #   path = "/dns-query";
      #   cert_file = config.sops.secrets.dnscrypt-cert-key.path;
      #   cert_key_file = config.sops.secrets.dnscrypt-cert-key.path;
      # };
      #
      # monitoring_ui = {
      #   enabled = true;
      #   username = "admin";
      #   password = "admin";
      #   listen_address = "127.0.0.1:8079";
      #   privacy_level = 1;
      # };

      # server_names = [ "adguard-dns-doh" ];
      listen_addresses = [ "127.0.0.1:5335" ];
    };
  };
  # services.dnscrypt-proxy.settings.systemd.services.dnscrypt-proxy.serviceConfig.StateDirectory =
  #   StateDirectory;

}

{ ... }:
{
  networking.firewall = {
    allowedTCPPorts = [ 3003 ];
  };
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    port = 3003;
    settings = {
      http = {
        # You can select any ip and port, just make sure to open firewalls where needed
        address = "127.0.0.1:3003";
      };
      dns = {
        upstream_dns = [
          # Example config with quad9
          "https://dns.quad9.net/dns-query"
          "tls://dns.quad9.net"
          # "9.9.9.9"
          # "149.112.112.112"
          # Uncomment the following to use a local DNS service (e.g. Unbound)
          # Additionally replace the address & port as needed
          # "127.0.0.1:5335"
        ];
        bootstrap_dns = [
          "9.9.9.9"
          "149.112.112.112"
          "2620:fe::fe"
          "2620:fe::9"
        ];
      };
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;

        parental_enabled = false; # Parental control-based DNS requests filtering.
        safe_search = {
          enabled = false; # Enforcing "Safe search" option for search engines, when possible.
        };
      };
      # The following notation uses map
      # to not have to manually create {enabled = true; url = "";} for every filter
      # This is, however, fully optional
      filters =
        map
          (url: {
            enabled = true;
            url = url;
          })
          [
            "https://badblock.celenity.dev/abp/badblock_plus.txt"
            "https://big.oisd.nl"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/ultimate.txt"
            "https://raw.githubusercontent.com/fmhy/FMHYFilterlist/main/filterlist.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/tif.txt"

            "https://badblock.celenity.dev/abp/unsafe.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Dandelion%20Sprout's%20Anti-Malware%20List.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/dyndns.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/spam-tlds-ublock.txt"
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt" # The Big List of Hacked Malware Web Sites
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt" # malicious url blocklist
          ];
    };
  };
}

{ ... }:
{
  networking.firewall = {
    allowedTCPPorts = [ 3003 ];
  };
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    host = "127.0.0.1";
    port = 3003;
    settings = {
      dns = {
        enable_dnssec = true;
        anonymize_client_ip = true;
        upstream_dns = [
          "127.0.0.1:5335"
        ];
      };

      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
        filters_update_interval = 12;

        parental_enabled = false;
        safe_search = {
          enabled = false;
        };
      };

      filters =
        map
          (url: {
            enabled = true;
            url = url;
          })
          [
            ### ================== Suspicious Lists ==================
            #
            "https://badblock.celenity.dev/abp/badblock_plus.txt"
            "https://big.oisd.nl"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/ultimate.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/tif.txt"
            "https://raw.githubusercontent.com/fmhy/FMHYFilterlist/main/filterlist.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/dyndns.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/spam-tlds-ublock.txt"
            #
            #
            ### ================== Suspicious Lists ==================
            #
            # PolishFiltersTeam KADhosts:
            "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"
            # Fademind's Spammers:
            "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"
            # WaLLy3K's Blacklist:
            "https://v.firebog.net/hosts/static/w3kbl.txt"
            #
            #
            ### ================== Advertising Lists ==================
            #
            # AdAway:
            "https://adaway.org/hosts.txt"
            # Adguard DNS:
            "https://v.firebog.net/hosts/AdguardDNS.txt"
            # LanikSJ's Admiral Anti-Adblock:
            "https://v.firebog.net/hosts/Admiral.txt"
            # Anudeep ND's Blacklist:
            "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
            # Easylist:
            "https://v.firebog.net/hosts/Easylist.txt"
            # Peter Lowe's Adservers:
            "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
            # Fademind's Unchecky Ads:
            "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts"
            # hostsVN:
            "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
            #
            #
            ### ================== Tracking & Telemetry Lists ==================
            #
            # Easyprivacy:
            "https://v.firebog.net/hosts/Easyprivacy.txt"
            # Fabrice Prigent's Ads:
            "https://v.firebog.net/hosts/Prigent-Ads.txt"
            # Fademind's 2o7 Network Trackers:
            "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts"
            # Crazy Max's Microsoft Telemetry:
            "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
            # Geoffrey Frogeye's First-Party Trackers:
            "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"
            #
            #
            ### ================== Malicious Lists ==================
            #
            # DandelionSprout's Anti Malware Filter:
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"
            # Fabrice Prigent's Cryptojacking:
            "https://v.firebog.net/hosts/Prigent-Crypto.txt"
            # Fademind's Risky Hosts:
            "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts"
            # Phishing Army's Extended Blocklist:
            "https://phishing.army/download/phishing_army_blocklist_extended.txt"
            # Quidsup Malicious:
            "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
            # Spam404:
            "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt"
            # Echap's Stalkerware Indicators:
            "https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts"
            # URLhaus Malicious URL blocklist:
            "https://urlhaus.abuse.ch/downloads/hostfile/"
            # CyberHost.uk Malware Domains:
            "https://lists.cyberhost.uk/malware.txt"
            #
            #
            ### ================== Adguard sourced ==================
            #
            # "https://adguardteam.github.io/HostlistsRegistry/assets/filter_24.txt" # 1Hosts (Lite)
            # "https://adguardteam.github.io/HostlistsRegistry/assets/filter_70.txt" # 1Hosts (Xtra)
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt" # Adguard DNS Filter
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_59.txt" # Adguard Popup host filter
            # "https://adguardteam.github.io/HostlistsRegistry/assets/filter_53.txt" # AWAvenue Ads rule
            # "https://adguardteam.github.io/HostlistsRegistry/assets/filter_4.txt" # Dan pollocks lists
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_69.txt" # ShadowWhisperer Tracking
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt" # The Big List of Hacked Malware Web Sites
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt" # malicious url blocklist
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_42.txt" # Shadow Malware
          ];
    };
  };
}

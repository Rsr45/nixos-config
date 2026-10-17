{...}: {
  networking.firewall = {
    allowedTCPPorts = [3003];
  };
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    # host = "127.0.0.1";
    # port = 3003;
    settings = {
      http.address = "127.0.0.1:3003";
      dns = {
        port = 53;
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
        # safebrowsing_enabled = true;
        safe_search = {
          enabled = true;
          youtube = false;
        };
      };

      user_rules = [
        "@@||cdn.donmai.us^$important"
        "@@||safebooru.donmai.us^$important"
        "@@||zerochan.net^$important"
        "@@||wotaku.wiki^$important"
        "@@||weebcentral.com^$important"
        "@@||update.sleazyfork.org^$important"
      ];

      whitelist_filters =
        map (url: {
          enabled = true;
          url = url;
        }) [
          "https://hagezi-mirror.dnsbunker.org/adblock/whitelist-referral.txt"
          "https://badblock.celenity.dev/abp/whitelist.txt"
        ];

      filters =
        map
        (url: {
          enabled = true;
          url = url;
        })
        [
          ### ================== Suspicious Lists ==================
          # PolishFiltersTeam KADhosts:
          "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"
          # Fademind's Spammers:
          "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"
          # WaLLy3K's Blacklist:
          "https://v.firebog.net/hosts/static/w3kbl.txt"
          ### ================== Advertising Lists ==================
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
          ### ================== Tracking & Telemetry Lists ==================
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
          ### ================== Malicious Lists ==================
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
          ### ================== Adguard sourced ==================
          # "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt" # Adguard DNS Filter
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_59.txt" # Adguard Popup host filter

          ## Adult, Dating, Gambling etc.
          "https://nsfw.oisd.nl"
          "https://hagezi-mirror.dnsbunker.org/adblock/gambling.txt"
          "https://hagezi-mirror.dnsbunker.org/adblock/nsfw.txt"
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn-only/hosts"
          "https://blocklistproject.github.io/Lists/adguard/drugs-ags.txt"
          "https://blocklistproject.github.io/Lists/adguard/gambling-ags.txt"
          "https://blocklistproject.github.io/Lists/adguard/porn-ags.txt"
          "https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/Lists/Adult"
          "https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/Lists/Dating"
          "https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/Lists/Gambling"
          "https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/Lists/Shock"
          "https://raw.githubusercontent.com/olbat/ut1-blacklists/master/blacklists/adult/domains.0"
          "https://raw.githubusercontent.com/olbat/ut1-blacklists/master/blacklists/adult/domains.1"
          "https://raw.githubusercontent.com/olbat/ut1-blacklists/master/blacklists/adult/domains.2"
          "https://raw.githubusercontent.com/olbat/ut1-blacklists/master/blacklists/dating/domains"
          "https://raw.githubusercontent.com/olbat/ut1-blacklists/master/blacklists/gambling/domains"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DatingSites"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/gambling"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/pornblock1"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/pornblock2"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/pornblock3"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/pornblock4"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/pornblock5"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/pornblock6"

          "https://big.oisd.nl"
          "https://cdn.jsdelivr.net/gh/badmojr/1Hosts@master/Lite/adblock.txt"
          "https://hagezi-mirror.dnsbunker.org/adblock/ultimate.txt"
          "https://hagezi-mirror.dnsbunker.org/adblock/tif.txt"
          "https://hagezi-mirror.dnsbunker.org/adblock/dyndns.txt"
          "https://hagezi-mirror.dnsbunker.org/adblock/nosafesearch.txt"
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          "https://raw.githubusercontent.com/fmhy/FMHYFilterlist/main/filterlist.txt"
          "https://someonewhocares.org/hosts/zero/hosts"

          "https://blocklistproject.github.io/Lists/adguard/abuse-ags.txt"
          "https://blocklistproject.github.io/Lists/adguard/ads-ags.txt"
          "https://blocklistproject.github.io/Lists/adguard/crypto-ags.txt"
          "https://blocklistproject.github.io/Lists/adguard/fraud-ags.txt"
          "https://blocklistproject.github.io/Lists/adguard/malware-ags.txt"
          "https://blocklistproject.github.io/Lists/adguard/ransomware-ags.txt"
          "https://blocklistproject.github.io/Lists/adguard/redirect-ags.txt"
          "https://blocklistproject.github.io/Lists/adguard/phishing-ags.txt"
          "https://blocklistproject.github.io/Lists/adguard/scam-ags.txt"
          "https://blocklistproject.github.io/Lists/adguard/tracking-ags.txt"
          "https://blocklistproject.github.io/Lists/adguard/tiktok-ags.txt"
          "https://phishing.army/download/phishing_army_blocklist_extended.txt"
          "https://raw.githubusercontent.com/cbuijs/accomplist/master/typosquat/plain.black.domain.list"
          "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt"
          "https://raw.githubusercontent.com/olbat/ut1-blacklists/master/blacklists/astrology/domains"
          "https://raw.githubusercontent.com/olbat/ut1-blacklists/master/blacklists/cryptojacking/domains"
          "https://raw.githubusercontent.com/olbat/ut1-blacklists/master/blacklists/bitcoin/domains"
          "https://raw.githubusercontent.com/olbat/ut1-blacklists/master/blacklists/fakenews/domains"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/Corona-Blocklist"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/crypto"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting1"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting2"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting3"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting4"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/Fake-Science"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/malware"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/MS-Office-Telemetry"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/Phishing-Angriffe"
          "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/Win10Telemetry"
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-only/hosts"
          "https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/Lists/Ads"
          "https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/Lists/Cryptocurrency"
          "https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/Lists/Scam"
          "https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/Lists/Malware"
          "https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/Lists/Tracking"
          "https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/Lists/Typo"
        ];
    };
  };
}

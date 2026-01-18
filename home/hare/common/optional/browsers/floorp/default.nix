{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./pref.nix
    ./bookmarks.nix
  ];
  programs.floorp = {
    enable = true;
    package = pkgs.floorp-bin.override {
      # See nixpkgs' firefox/wrapper.nix to check which options you can use
      nativeMessagingHosts = with pkgs; [
        # Tridactyl native connector
        tridactyl-native
      ];
    };
    nativeMessagingHosts = with pkgs; [
      tridactyl-native
    ];
    policies = {
      ExtensionSettings =
        with builtins;
        let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "normal_installed";
            };
          };
        in
        listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "sidebery" "{3c078156-979c-498b-8990-85f7987dd929}")
          (extension "darkreader" "addon@darkreader.org")
          (extension "violentmonkey" "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}")
          (extension "sponsorblock" "sponsorBlocker@ajay.app")
          (extension "tridactyl-vim" "tridactyl.vim@cmcaine.co.uk")
        ];
      # To add additional extensions, find it on addons.mozilla.org, find
      # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
      # Then, download the XPI by filling it in to the install_url template, unzip it,
      # run `jq .browser_specific_settings.gecko.id manifest.json` or
      # `jq .applications.gecko.id manifest.json` to get the UUID
      BlockAboutConfig = false;
      DisableFirefoxAccounts = true;
      DefaultDownloadDirectory = "\${home}/Downloads";
    };
    profiles.default = {
      isDefault = true;
      userChrome = builtins.readFile ./remove-tab.css + builtins.readFile ./sidebar-header.css;
      extensions.force = true;
      extensions = {
        settings = {
          "uBlock0@raymondhill.net".settings =
            let
              importedLists = [
                "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt"
                "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
                "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/BrowseWebsitesWithoutLoggingIn.txt"
                "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"
                "https://raw.githubusercontent.com/liamengland1/miscfilters/master/antipaywall.txt"

                ## ----- Privacy -----
                "https://badblock.celenity.dev/abp/click-tracking.txt"
                "https://raw.githubusercontent.com/yokoffing/filterlists/main/block_third_party_fonts.txt"

                ## ----- Malware -----
                "https://badblock.celenity.dev/abp/unsafe.txt"
                "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Dandelion%20Sprout's%20Anti-Malware%20List.txt"
                "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/dyndns.txt"
                "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/spam-tlds-ublock.txt"
                "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/tif.txt"
                "https://raw.githubusercontent.com/fmhy/FMHYFilterlist/main/filterlist.txt"

                ## ----- Multipurpose -----
                "https://badblock.celenity.dev/abp/badblock_plus.txt"
                "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/ultimate.txt"

                ## ----- Annoyances -----
                "https://gitflic.ru/project/magnolia1234/bypass-paywalls-clean-filters/blob/raw?file=bpc-paywall-filter.txt"

                "https://raw.githubusercontent.com/mchangrh/yt-neuter/main/yt-neuter.txt"
                "https://raw.githubusercontent.com/mchangrh/yt-neuter/main/filters/sponsorblock.txt"
              ];
            in
            {
              # userFilters = lib.concatMapStrings (x: x + "\n") [
              #   "twitch.tv##+js(twitch-videoad)"
              #   "||1337x.vpnonly.site"
              # ];
              uiAccentCustom = true;
              uiAccentCustom0 = "#CF1D25";
              cloudStorageEnabled = lib.mkForce false;
              advancedUserEnabled = true;
              userFiltersTrusted = true;
              importedLists = importedLists;
              externalLists = lib.concatStringsSep "\n" importedLists;
              popupPanelSections = 31;
              selectedFilterLists = [
                "user-filters"
                "ublock-filters"
                "ublock-badware"
                "ublock-privacy"
                "ublock-quick-fixes"
                "ublock-unbreak"
                ## ----- Ads -----
                "easylist"
                # "adguard-generic"
                "adguard-mobile"
                ## ----- Privacy -----
                "easyprivacy"
                "LegitimateURLShortener"
                # "adguard-spyware" # removed
                "adguard-spyware-url"
                "block-lan"
                ## ----- Malware -----
                "urlhaus-1"
                # "curben-phishing"
                ## ----- Multipurpose -----
                "plowe-0"
                "dpollock-0"
                ## ----- Cookie Notices -----
                ### ----- Easylist -----
                "fanboy-cookiemonster"
                "ublock-cookies-easylist"
                ### ----- Adguard -----
                # "adguard-cookies"
                # "ublock-cookies-adguard"
                ## ----- Social -----
                "fanboy-social"
                # "adguard-social"
                "fanboy-thirdparty_social"
                ## ----- Annoyances -----
                ### ----- Easylist -----
                "easylist-chat"
                "easylist-newsletters"
                "easylist-notifications"
                "easylist-annoyances"
                ### ----- Adguard -----
                # "adguard-mobile-app-banners"
                # "adguard-other-annoyances"
                # "adguard-popup-overlays"
                # "adguard-widgets"
                ### ----- uBlock -----
                "ublock-annoyances"
                ## ----- Region -----
                "KOR-0"
                "TUR-0"
                "DEU-0"
                "FRA-0"
                "NLD-0"
              ]
              ++ importedLists;
            };
        };
      };

      search = {
        default = "htmlddg";
        privateDefault = "Startpage";
        force = true;
        order = [
          "htmlddg"
          "Startpage"
          "ddg"
          "nixos-wiki"
          "nixos-options"
          "nix-packages"
          "google"
          "bing"
        ];
        engines = {
          searx = {
            name = "SearchXNG";
            urls = [
              {
                template = "http://localhost:8080/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "'s" ];
          };
          htmlddg = {
            name = "DuckDuckGo (HTML)";
            urls = [
              {
                template = "https://html.duckduckgo.com/html/";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
          nix-packages = {
            name = "Nix Packages";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "'np" ];
          };
          nixos-options = {
            name = "NixOS Options";
            definedAliases = [ "'no" ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "type";
                    value = "packages";
                  }
                ];
              }
            ];
          };
          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = [ "'nw" ];
          };
        };
      };
    };
  };
}

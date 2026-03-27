{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    # ./bookmarks.nix
  ];
  programs.floorp = {
    enable = true;
    # package = pkgs.floorp-bin.override {
    #   # See nixpkgs' firefox/wrapper.nix to check which options you can use
    #   nativeMessagingHosts = with pkgs; [
    #     # Tridactyl native connector
    #     tridactyl-native
    #   ];
    # };
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
          (extension "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
          (extension "view-page-archive" "{d07ccf11-c0cd-4938-a265-2a4d6ad01189}")
          (extension "steam-database" "firefox-extension@steamdb.info")
          (extension "augmented-steam" "{1be309c5-3e4f-4b99-927d-bb500eb4fa88}")
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
      userChrome = builtins.readFile ./userChrome.css;
      userContent = builtins.readFile ./userContent.css;
      extraConfig =
        builtins.replaceStrings [ "\npref(" ] [ "\nuser_pref(" ] (builtins.readFile ../phoenix-desktop.js)
        + builtins.readFile ./preferred.js;

      containersForce = true;
      containers = {
        personal = {
          color = "blue";
          icon = "fingerprint";
          id = 1;
        };
        work = {
          color = "orange";
          icon = "briefcase";
          id = 2;
        };
        shopping = {
          color = "pink";
          icon = "cart";
          id = 3;
        };
        bank = {
          color = "green";
          icon = "dollar";
          id = 4;
        };
        dangerous = {
          color = "red";
          icon = "fruit";
          id = 5;
        };
        school = {
          color = "yellow";
          icon = "circle";
          id = 6;
        };
        google = {
          color = "toolbar";
          icon = "circle";
          id = 7;
        };
        youtube = {
          color = "toolbar";
          icon = "circle";
          id = 8;
        };
        goon = {
          color = "toolbar";
          icon = "circle";
          id = 9;
        };
        tmp = {
          color = "toolbar";
          icon = "circle";
          id = 10;
        };
        ai = {
          color = "toolbar";
          icon = "circle";
          id = 11;
        };
        misc = {
          color = "toolbar";
          icon = "circle";
          id = 12;
        };
        whatsapp = {
          color = "green";
          icon = "circle";
          id = 13;
        };
        reddit = {
          color = "toolbar";
          icon = "circle";
          id = 14;
        };
        dev = {
          color = "turquoise";
          icon = "circle";
          id = 15;
        };
      };
      extensions.force = true;
      extensions = {
        settings = {
          "uBlock0@raymondhill.net".settings =
            let
              importedLists = [
                "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt"
                "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
                "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/BrowseWebsitesWithoutLoggingIn.txt"
                # "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"
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
                "https://raw.githubusercontent.com/mchangrh/yt-neuter/main/filters/noview.txt"
              ];
            in
            {
              uiAccentCustom = true;
              uiAccentCustom0 = "#CF1D25";
              cloudStorageEnabled = lib.mkForce false;
              advancedUserEnabled = true;
              userFiltersTrusted = true;
              popupPanelSections = 31;
              importedLists = importedLists;
              externalLists = lib.concatStringsSep "\n" importedLists;
              hostnameSwitchesString = ''
                no-large-media: behind-the-scene false
                no-csp-reports: * true
              '';
              dynamicFilteringString = ''
                behind-the-scene * * noop
                behind-the-scene * 1p-script noop
                behind-the-scene * 3p noop
                behind-the-scene * 3p-frame noop
                behind-the-scene * 3p-script noop
                behind-the-scene * image noop
                behind-the-scene * inline-script noop
                * * 3p-frame block
                * challenges.cloudflare.com * noop
                * www.google.com * noop
                * www.gstatic.com * noop
                * hcaptcha.com * noop
                * recaptcha.net * noop
                x.com twitter.com * noop
                twitter.com x.com * noop
              '';
              user-filters = ''
                *$font,third-party
                xn--*
                xn--*$doc,popup,frame
                ||doubleclick.net^$important
                ||google-analytics.com^$important
                ||facebook.com^$important,third-party
                ||facebook.net^$important,third-party
                ||linkedin.com^$important,third-party
                ||instagram.com^$important,third-party
                ||tiktok.com^$important,third-party
                ||twitter.com^$third-party,domain=~x.com
                ||x.com^$third-party
                ||gravatar.com^$important,third-party
                ||accounts.google.com^$third-party,domain=~chromium.org|~gstatic.com|~googleusercontent.com|~youtube.com
                ||appleid.apple.com^$third-party,domain=~appleid.cdn-apple.com
                ||appleid.cdn-apple.com^$third-party,domain=~appleid.apple.com
                ||challenges.cloudflare.com^$third-party
                @@||challenges.cloudflare.com/cdn-cgi/challenge-platform/$third-party,script,frame
                ||www.google.com^$third-party,subdocument
                @@||www.google.com/recaptcha/$third-party,subdocument
                ||www.gstatic.com^$third-party,script
                @@||www.gstatic.com/recaptcha/$third-party,script
              '';
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

          # "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}".settings = {
          #   styles = lib.importJSON.packages.catppuccin-userstyles;
          # };
        };
      };

      search = {
        default = "brave";
        privateDefault = "startpage";
        force = true;
        order = [
          "ddg"
          "brave"
          "startpage"
          "htmlddg"
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
          brave = {
            name = "Brave";
            urls = [
              {
                template = "https://search.brave.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
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

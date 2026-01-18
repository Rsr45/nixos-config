{ pkgs, lib, ... }:
{
  programs.firefox.profiles = {
    phoenix = {
      id = 1;
      extraConfig =
        builtins.replaceStrings [ "\npref(" ] [ "\nuser_pref(" ] (builtins.readFile ./phoenix.js)
        + builtins.readFile ./preferred.js;
      userChrome = builtins.readFile ./phoenix-userChrome.css;
      userContent = builtins.readFile ./phoenix-userContent.css;

      search = {
        default = "startpage";
        privateDefault = "startpage";
        force = true;
        order = [
          "startpage"
          "ddg"
          "ddg-html"
          "nixos-wiki"
          "nixos-options"
          "nix-packages"
          "google"
          "bing"
        ];

        engines = {
          startpage = {
            name = "Startpage";
            urls = [
              {
                template = "https://www.startpage.com/sp/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          ddg-html = {
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

      extensions = {
        force = true;
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
              ];
            in
            {
              advancedUserEnabled = true;
              uiAccentCustom = true;
              uiAccentCustom0 = "#CF1D25";
              cloudStorageEnabled = lib.mkForce false;
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
                ## ----- Builtin -----
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
    };
  };
}

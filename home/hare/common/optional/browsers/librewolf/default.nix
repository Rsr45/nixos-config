{ pkgs, lib, ... }:
{
  imports = [
    # ./userChrome.nix
    # ./userContent.nix
  ];
  programs.librewolf = {
    enable = true;
    # package = pkgs.librewolf.override {
    #   # See nixpkgs' firefox/wrapper.nix to check which options you can use
    #   nativeMessagingHosts = with pkgs; [
    #     # Gnome shell native connector
    #     # gnome-browser-connector
    #     # Tridactyl native connector
    #     tridactyl-native
    #     pywalfox-native
    #   ];
    # };
    nativeMessagingHosts = with pkgs; [
      tridactyl-native
      # pywalfox-native
    ];
    policies = {
      ExtensionSettings =
        with builtins;
        let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        in
        listToAttrs [
          # (extension "ublock-origin" "uBlock0@raymondhill.net")
          # (extension "violentmonkey" "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}")
          # (extension "sponsorblock" "sponsorBlocker@ajay.app")
          # (extension "sidebery" "{3c078156-979c-498b-8990-85f7987dd929}")
          # (extension "darkreader" "addon@darkreader.org")
          (extension "tridactyl-vim" "tridactyl.vim@cmcaine.co.uk")
          # (extension "pywalfox" "pywalfox@frewacom.org") # same as keepass
          # (extension "keepassxc-browser" "keepassxc-browser@keepassxc.org") # firejail setup needed
        ];
      # To add additional extensions, find it on addons.mozilla.org, find
      # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
      # Then, download the XPI by filling it in to the install_url template, unzip it,
      # run `jq .browser_specific_settings.gecko.id manifest.json` or
      # `jq .applications.gecko.id manifest.json` to get the UUID
      BlockAboutConfig = false;
      DisableFirefoxAccounts = true;
      DefaultDownloadDirectory = "\${home}/Downloads";
      NoDefaultBookmarks = false; # supposed to be fixed https://github.com/nix-community/home-manager/pull/7399
    };
    profiles.default = {
      isDefault = true;
      extensions.force = true;
      # userChrome = builtins.readFile ./remove-tab.css + builtins.readFile ./sidebar-header.css;
      # userContent = "\n@import url(extrac.css);\n";
      # extraConfig =
      #   builtins.replaceStrings [ "\npref(" ] [ "\nuser_pref(" ] (builtins.readFile ../phoenix-desktop.js)
      #   + builtins.readFile ../preferred.js;
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
        };
      };

      search = import ../search.nix { inherit pkgs; };
    };
  };
}

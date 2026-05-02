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

  xdg.configFile = {
    "tridactyl/tridactylrc" = {
      source = ./tridactylrc;
    };
  };
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
          # (extension "adnauseam" "adnauseam@rednoise.org") ## cool
          (extension "sidebery" "{3c078156-979c-498b-8990-85f7987dd929}")
          (extension "darkreader" "addon@darkreader.org")
          (extension "violentmonkey" "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}")
          (extension "sponsorblock" "sponsorBlocker@ajay.app")
          (extension "tridactyl-vim" "tridactyl.vim@cmcaine.co.uk")
          (extension "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
          (extension "view-page-archive" "{d07ccf11-c0cd-4938-a265-2a4d6ad01189}")
          (extension "steam-database" "firefox-extension@steamdb.info")
          (extension "augmented-steam" "{1be309c5-3e4f-4b99-927d-bb500eb4fa88}")
          (extension "libredirect" "7esoorv3@alefvanoon.anonaddy.me")
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
      settings =
        let
          blocklists = builtins.concatStringsSep "|" [
            "https://easylist.to/easylist/easylist.txt"
            "https://easylist.to/easylist/easyprivacy.txt"
            "https://secure.fanboy.co.nz/fanboy-annoyance.txt"
            "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt"
            ## Regional
            "https://easylist-downloads.adblockplus.org/indianlist.txt"
            "https://easylist-downloads.adblockplus.org/advblock.txt"
            "https://easylist.to/easylistgermany/easylistgermany.txt"
            "https://easylist-downloads.adblockplus.org/easylistchina.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/NorwegianExperimentalList%20alternate%20versions/NordicFiltersABP-Inclusion.txt"
            ## Annoyances + Misc(non-ad)
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AnnoyancesList"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AnnoyancesList-2ndDivision.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AntiAbusePorn.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AntiSubmissiveEroticaList.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Special%20security%20lists/AntiFaviconList.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AntiFakeTransparentImagesList.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AntiFunctionalityRemovalList.txt"
            ## Malware
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Dandelion%20Sprout's%20Anti-Malware%20List.txt"

            "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt"
            "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/BrowseWebsitesWithoutLoggingIn.txt"
            # "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"
            "https://raw.githubusercontent.com/liamengland1/miscfilters/master/antipaywall.txt"

            ## ----- Privacy -----
            "https://badblock.celenity.dev/abp/click-tracking.txt"
            "https://raw.githubusercontent.com/yokoffing/filterlists/main/block_third_party_fonts.txt"
            "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt"

            ## ----- Malware -----
            "https://badblock.celenity.dev/abp/unsafe.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Dandelion%20Sprout's%20Anti-Malware%20List.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/dyndns.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/spam-tlds-ublock.txt"
            # "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/tif.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/tif.mini.txt"
            "https://raw.githubusercontent.com/fmhy/FMHYFilterlist/main/filterlist.txt"

            ## ----- Multipurpose -----
            "https://badblock.celenity.dev/abp/badblock_plus.txt"
            # "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/ultimate.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/ultimate.mini.txt"

            ## ----- Annoyances -----
            "https://gitflic.ru/project/magnolia1234/bypass-paywalls-clean-filters/blob/raw?file=bpc-paywall-filter.txt"

            "https://raw.githubusercontent.com/mchangrh/yt-neuter/main/yt-neuter.txt"
            "https://raw.githubusercontent.com/mchangrh/yt-neuter/main/filters/sponsorblock.txt"
            "https://raw.githubusercontent.com/mchangrh/yt-neuter/main/filters/noview.txt"

            ## Browse functions
            "https://codeberg.org/celenity/BadBlock/raw/branch/pages/hardened/block-webrtc.txt"
            # "https://codeberg.org/celenity/BadBlock/raw/branch/pages/hardened/unbreak-webrtc.txt"
            "https://codeberg.org/celenity/BadBlock/raw/branch/pages/hardened/block-webgpu.txt"
            # "https://codeberg.org/celenity/BadBlock/raw/branch/pages/hardened/unbreak-webgpu.txt"
          ];
        in
        {

          ## Updates
          "app.update.checkInstallTime.days" = 0;
          "app.update.badgeWaitTime" = 0;
          "app.update.notifyDuringDownload" = true;
          "app.update.promptWaitTime" = 0;
          "extensions.systemAddon.update.enabled" = true;
          "extensions.update.autoUpdateDefault" = true;
          "extensions.update.enabled" = true;
          "app.update.background.interval" = 3600;
          "app.update.interval" = 3600;
          "extensions.update.interval" = 3600;
          "services.settings.poll_interval" = 3600;
          "extensions.checkUpdateSecurity" = true;

          ## Privacy
          "privacy.query_stripping.strip_list" =
            "__hsfp __hssc __hstc __s _bhlid _branch_match_id _branch_referrer _gl _hsenc _kx _openstat at_recipient_id at_recipient_list bbeml bsft_clkid bsft_uid dclid et_rid fb_action_ids fb_comment_id fbclid gbraid gclid guce_referrer guce_referrer_sig hsCtaTracking igshid irclickid mc_eid mkt_tok ml_subscriber ml_subscriber_hash msclkid mtm_cid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id pk_cid rb_clickid s_cid sc_customer sc_eh sc_uid srsltid ss_email_id twclid unicorn_click_id vero_conv vero_id vgo_ee wbraid wickedid yclid ymclid ysclid";
          # "privacy.query_stripping.allow_list" = "urldefense.com";

          "permissions.isolateBy.userContext" = true;
          "privacy.antitracking.isolateContentScriptResources" = true;
          "network.cookie.maxageCap" = 15552000;
          "autoadmin.append_emailaddr" = false;
          "privacy.dynamic_firstparty.limitForeign" = true;

          "network.http.referer.defaultPolicy.trackers" = 1;
          "network.http.referer.defaultPolicy.trackers.pbmode" = 1;
          "privacy.query_stripping.strip_on_share.enabled" = true;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "network.http.referer.XOriginPolicy" = 2;

          ## PDF Reader
          "pdfjs.disabled" = false;
          "pdfjs.enableScripting" = false;
          "pdfjs.enableAltTextModelDownload" = false;
          "pdfjs.enableGuessAltText" = false;
          "pdfjs.enableAutoLinking" = false;
          "pdfjs.enableXfa" = false;
          "pdfjs.enableSignatureEditor" = true;
          "pdfjs.enableAltText" = true;
          "pdfjs.enableAltTextForEnglish" = true;
          "pdfjs.enableNewAltTextWhenAddingImage" = true;
          "pdfjs.enableUpdatedAddImage" = true;
          "pdfjs.enableHWA" = true;
          "pdfjs.enableOptimizedPartialRendering" = true;
          "pdfjs.disableFontFace" = true;
          "pdfjs.textLayerMode" = 1;
          "browser.download.open_pdf_attachments_inline" = false;
          "pdfjs.disableRange" = true;
          "pdfjs.disableStream" = true;
          "pdfjs.enablePermissions" = false;
          "pdfjs.externalLinkTarget" = 2;
          "pdfjs.handleOctetStream" = false;
          # "pdfjs.sidebarViewOnLoad"= 2;
          "pdfjs.historyUpdateUrl" = true;

          ##
          "network.IDN_show_punycode" = true;
          "browser.urlbar.trimHttps" = false;
          "browser.urlbar.trimURLs" = false;

          "signon.autofillForms" = false;
          "signon.formlessCapture.enabled" = false;
          "network.auth.subresource-http-auth-allow" = 1;

          ## AI
          "browser.ai.control.default" = "blocked";
          "browser.ai.control.linkPreviewKeyPoints" = "blocked";
          "browser.ai.control.pdfjsAltText" = "blocked";
          "browser.ai.control.sidebarChatbot" = "blocked";
          "browser.ai.control.smartTabGroups" = "blocked";
          "browser.ai.control.smartWindow" = "blocked";
          "browser.preferences.aiControls" = false;

          "extensions.htmlaboutaddons.local_model_management" = true;
          "browser.ml.enable" = false;
          "browser.ml.chat.enabled" = false;
          "browser.ml.chat.menu" = false;
          "browser.ml.chat.page" = false;
          "browser.ml.chat.sidebar" = false;
          "extensions.formautofill.ml.experiment.enabled" = false;
          "browser.aiwindow.apiKey" = "";
          "browser.aiwindow.enabled" = false;
          "browser.aiwindow.endpoint" = "";
          "browser.aiwindow.insights" = false;
          "browser.aiwindow.memories" = false;
          "browser.aiwindow.model" = "";
          "browser.smartwindow.apiKey" = "";
          "browser.smartwindow.enabled" = false;
          "browser.smartwindow.endpoint" = "";
          "browser.smartwindow.memories" = false;
          "browser.smartwindow.model" = "";
          "browser.smartwindow.preferences.endpoint" = "";
          "browser.ml.linkPreview.collapsed" = true;
          "browser.ml.linkPreview.longPress" = false;
          "browser.ml.linkPreview.optin" = false;
          "browser.ml.linkPreview.supportedLocales" = "null";
          "browser.ml.pageAssist.enabled" = false;
          "browser.urlbar.perplexity.hasBeenInSearchMode" = true;
          "places.semanticHistory.featureGate" = false;
          "browser.ml.smartAssist.apiKey" = "";
          "browser.ml.smartAssist.enabled" = false;
          "browser.ml.smartAssist.endpoint" = "";
          "browser.ml.smartAssist.model" = "";
          "browser.ml.smartAssist.overrideNewTab" = false;
          "extensions.ml.enabled" = false;
          "browser.tabs.groups.smart.enabled" = false;
          "browser.tabs.groups.smart.optin" = false;
          "browser.tabs.groups.smart.userEnabled" = false;
          "browser.ml.chat.providers" = "";
          "browser.ml.chat.provider" = "https://duck.ai/";

          ## Link Preview
          "browser.ml.linkPreview.enabled" = true;
          "browser.ml.linkPreview.blockListEnabled" = false;

          ## Performance
          "browser.cache.jsbc_compression_level" = 3;
          "javascript.options.asyncstack" = false;
          "javascript.options.asyncstack_capture_debuggee_only" = true;
          "sidebar.animation.enabled" = false;
          "ui.panelAnimations" = 0;
          "ui.prefersReducedMotion" = 1;
          "ui.swipeAnimationEnabled" = 0;
          "layout.css.report_errors" = false;
          "extensions.logging.enabled" = false;
          "network.http.pacing.requests.enabled" = false;
          "browser.preferences.defaultPerformanceSettings.enabled" = false;
          "javascript.options.wasm_simd_avx" = true;
          "layers.acceleration.disabled" = false;

          ## Translations
          "browser.ai.control.translations" = "enabled";
          # "browser.translations.automaticallyPopup" = false;
          "browser.translations.enable" = true;
          "browser.translations.select.enable" = true;
          "browser.translations.newSettingsUI.enable" = true;
          "browser.translations.simulateUnsupportedEngine" = false;
          "extensions.translations.disabled" = false;

          "ui.key.menuAccessKeyFocuses" = false;

          ## JIT
          "javascript.options.ion" = false;
          "javascript.options.baselinejit" = false;
          "javascript.options.jithints" = false;
          ## Enable JIT for WebExtensions
          "javascript.options.jit_trustedprincipals" = true;
          ## WebAssembly
          "javascript.options.wasm" = true;
          "javascript.options.main_process_disable_jit" = true;
          "javascript.options.native_regexp" = false;
          "javascript.options.wasm_baselinejit" = true;
          "javascript.options.wasm_optimizingjit" = false;
          ## Misc
          "javascript.options.asmjs" = false;
          "mathml.disabled" = true;
          "svg.disabled" = false; # do not disable svg
          "gfx.font_rendering.graphite.enabled" = false;
          "gfx.font_rendering.opentype_svg.enabled" = false;
          "image.jxl.enabled" = false;
          "permissions.default.xr" = 2;
          ## Shared Memory
          "javascript.options.self_hosted.use_shared_memory" = false;
          "dom.postMessage.sharedArrayBuffer.bypassCOOP_COEP.insecure.enabled" = false;
          "dom.postMessage.sharedArrayBuffer.withCOOP_COEP" = false;
          ## DRM
          "media.eme.enabled" = false;
          "browser.eme.ui.enabled" = false;
          ## ETP
          "browser.contentblocking.category" = "strict";
          "privacy.antitracking.enableWebcompat" = false;
          "privacy.trackingprotection.allow_list.baseline.enabled" = true;
          "privacy.trackingprotection.allow_list.convenience.enabled" = false;
          ## RFP
          "privacy.resistFingerprinting" = true;
          "privacy.resistFingerprinting.pbmode" = true;
          "privacy.window.maxInnerWidth" = 1600;
          "privacy.window.maxInnerHeight" = 900;
          ## DOH & HTTPS
          "dom.security.https_only_mode" = true;
          "network.trr.mode" = 3;
          "network.trr.custom_uri" = "https://dns10.quad9.net/dns-query";
          "network.trr.uri" = "https://dns10.quad9.net/dns-query";

          # Set network.trr.custom_uri and network.trr.uri to https://127.0.0.1:3000/dns-query
          # Set network.trr.mode to 2 or 3 info
          # Set network.dns.echconfig.enabled to true
          # Set network.dns.use_https_rr_as_altsvc to true
          # Set network.security.esni.enabled to true (deprecated)

          "network.connectivity-service.DNS_HTTPS.domain" = "";
          "network.trr.attempt-when-retrying-confirmation" = true;
          "network.trr.confirmationNS" = "skip";
          "network.trr.skip-check-for-blocked-host" = true;
          "network.trr.wait-for-confirmation" = false;
          #
          # /// Disable EDNS Client Subnet (ECS) to prevent leaking general location data to authoritative DNS servers...
          # // https://wikipedia.org/wiki/EDNS_Client_Subnet
          # pref("network.trr.disable-ECS", true); // [DEFAULT]
          #
          # /// Disable falling back to system DNS by default
          # pref("network.trr.retry_on_recoverable_errors", true); // https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/nsHostResolver.cpp#1351
          # pref("network.trr.strict_native_fallback", true); // https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/telemetry/docs/data/environment.rst#418
          #
          # /// Disable nsNotifyAddrListener
          # // (Ex. used for disabling DoH if certain conditions are met)
          # // https://searchfox.org/firefox-main/source/netwerk/system/win32/nsNotifyAddrListener.cpp
          # pref("network.notify.changed", false);
          # pref("network.notify.checkForNRPT", false);
          # pref("network.notify.checkForProxies", false);
          # pref("network.notify.dnsSuffixList", false);
          # pref("network.notify.initial_call", false);
          # pref("network.notify.IPv6", false); // [DEFAULT - Windows]
          # pref("network.notify.resolvers", false);
          #
          # /// Enable DNS Rebinding Protection
          # // https://bugzilla.mozilla.org/show_bug.cgi?id=1672528
          # pref("network.trr.allow-rfc1918", false); // [DEFAULT]
          #
          # /// Enable DoH without fallback & Set to Quad9 by default
          # pref("network.trr.default_provider_uri", "https://dns.quad9.net/dns-query");
          # pref("network.trr.mode", 3);
          #
          # /// Enable EncryptedClientHello
          # // https://blog.cloudflare.com/announcing-encrypted-client-hello
          # pref("network.dns.echconfig.enabled", true); // [DEFAULT]
          # pref("network.dns.http3_echconfig.enabled", true); // [DEFAULT]
          #
          # /// Enable native DNS over HTTPS lookups
          # // NOTE: Native DNS over HTTPS is currently broken on Windows 10, but can be toggled anyways with the
          # // `network.dns.native_https_query_win10` pref: https://bugzilla.mozilla.org/show_bug.cgi?id=1873461
          # pref("network.dns.native_https_query", true); // [DEFAULT - non-macOS]
          # pref("network.dns.native_https_query_in_automation", true); // Used in automation
          #
          # /// Enable TLS SNI Slicing
          # // Useful for circumenting certain forms of censorship, ex. from the Great Firewall of China
          # // https://github.com/uazo/cromite/issues/2403
          # // https://github.com/net4people/bbs/issues/505
          # // https://searchfox.org/firefox-main/diff/cb527813/modules/libpref/init/StaticPrefList.yaml#15350
          # pref("network.http.http3.sni-slicing", true); // [DEFAULT]
          #
          # /// Ensure we clear cache upon changing DoH prefs
          # // https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/TRRService.cpp#440
          # pref("network.trr.clear-cache-on-pref-change", true); // [DEFAULT]
          #
          # /// Expose the DoH bootstrap pref, but don't configure by default
          # // This is the DNS server Firefox uses to resolve the address of your DoH server
          # // By default, Firefox just uses the system DNS
          # // This value MUST match the address of the DoH server you're using
          # // Ex. you could set this to "9.9.9.9" for Quad9
          # // We won't configure this by default to prevent unexpected breakage for users when switching DNS providers, but it's hidden - so we can at least expose it in the about:config
          # // https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/TRRService.cpp#903
          # pref("network.trr.bootstrapAddr", ""); // [HIDDEN] [DEFAULT]
          #
          # /// Fix IPv6 connectivity when DoH is enabled
          # // https://codeberg.org/divested/brace/pulls/5
          # pref("network.dns.preferIPv6", true);
          #
          # /// Prevent bypassing DoH for /etc/HOSTS entries by default
          # // Protects against HOSTS file hijacking
          # // https://www.malwarebytes.com/blog/news/2016/09/hosts-file-hijacks
          # // https://www.microsoft.com/wdsi/threats/malware-encyclopedia-description?Name=SettingsModifier:Win32/HostsFileHijack
          # // https://www.microcenter.com/tech_center/article/6472/how-to-clean-the-windows-hosts-file-if-malware-has-tampered-with-it
          # // https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/TRRServiceBase.cpp#359
          # pref("network.trr.exclude-etc-hosts", false);
          #
          # /// Prevent sending headers for DoH requests
          # pref("network.trr.send_accept-language_headers", false); // [DEFAULT]
          # pref("network.trr.send_empty_accept-encoding_headers", true); // [DEFAULT]
          # pref("network.trr.send_user-agent_headers", false); // [DEFAULT]

          ## Adblock baked into the browser?? - still need ub but obv better than wto in mem usage. beside seems to be used for etp not as a adblock so use ubo
          ## testing done
          # "privacy.trackingprotection.content.protection.enabled" = true;
          # "privacy.trackingprotection.content.protection.test_list_urls" = blocklists;

          # "layout.css.prefers-color-scheme.content-override" = 2;
          # "" = "";
          # General
          "browser.aboutConfig.showWarning" = false;

          "extensions.quarantineIgnoredByUser.tridactyl.vim@cmcaine.co.uk" = true;
          "general.autoScroll" = true;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
          "browser.translations.automaticallyPopup" = false;

          "svg.context-properties.content.enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          "widget.use-xdg-desktop-portal.file-picker" = 1;
          "widget.use-xdg-desktop-portal.location" = 1;
          "widget.use-xdg-desktop-portal.mime-handler" = 1;
          "widget.use-xdg-desktop-portal.open-uri" = 1;
          "widget.use-xdg-desktop-portal.settings" = 1;

          "widget.gtk.libadwaita-colors.enabled" = false;
          "browser.tabs.inTitlebar" = 0;

          "sidebar.revamp" = false;
          "sidebar.visibility" = "hide-sidebar";
          "browser.toolbars.bookmarks.visibility" = "never";

          "userChrome.hidden.urlbar_iconbox" = true;
          "userChrome.hidden.tabbar" = true;
          "userChrome.hidden.sidebar_header" = true;
          "userChrome.centered.urlbar" = true;
          "userChrome.autohide.back_button" = false;
          "userChrome.autohide.forward_button" = false;
          "floorp.workspaces.enabled" = false;
          "floorp.panelSidebar.enabled" = false;

          "floorp.keyboardshortcut.enabled" = true;
          "floorp.keyboardshortcut.config" = builtins.toJSON {
            "enabled" = true;
            "shortcuts" = {
              "gecko-show-next-tab" = {
                "modifiers" = {
                  "alt" = false;
                  "ctrl" = true;
                  "meta" = false;
                  "shift" = false;
                };
                "key" = "N";
                "action" = "gecko-show-next-tab";
              };
              "gecko-show-previous-tab" = {
                "modifiers" = {
                  "alt" = false;
                  "ctrl" = true;
                  "meta" = false;
                  "shift" = false;
                };

                "key" = "P";
                "action" = "gecko-show-previous-tab";
              };

              "gecko-close-window" = {
                modifiers = {
                  alt = false;
                  ctrl = true;
                  meta = false;
                  shift = false;
                };
                key = "Q";
                action = "gecko-close-window";
              };

              "gecko-scroll-up" = {
                action = "gecko-scroll-up";
                key = "U";
                modifiers = {
                  alt = false;
                  ctrl = true;
                  meta = false;
                  shift = false;
                };
              };

              "gecko-scroll-down" = {
                modifiers = {
                  alt = false;
                  ctrl = true;
                  meta = false;
                  shift = false;
                };
                key = "D";
                action = "gecko-scroll-down";
              };
            };
          };

          "floorp.newtab.configs" = builtins.toJSON {
            components = {
              topSites = false;
              clock = true;
              searchBar = true;
              firefoxLayout = false;
            };
            background = {
              type = "random";
              customImage = null;
              fileName = null;
              folderPath = null;
              selectedFloorp = null;
              slideshowEnabled = false;
              slideshowInterval = 30;
            };
            searchBar = {
              searchEngine = "default";
            };
            topSites = {
              pinned = [
                {
                  "url" = "https=//www.cube-soft.jp/";
                  "title" = "Cubesoft (Sponsor)";
                }
                {
                  "url" = "https=//docs.floorp.app/docs/features/";
                  "title" = "Floorp Support";
                }
              ];
              blocked = [ ];
            };
          };

          "floorp.design.configs" = builtins.toJSON {
            globalConfigs = {
              userInterface = "lepton";
              faviconColor = false;
              appliedUserJs = "";
            };

            tabbar = {
              tabbarStyle = "horizontal";
              tabbarPosition = "optimise-to-vertical-tabbar";
              multiRowTabBar = {
                maxRowEnabled = false;
                maxRow = 3;
              };
            };

            tab = {
              tabScroll = {
                enabled = false;
                reverse = false;
                wrap = false;
              };
              tabMinHeight = 30;
              tabMinWidth = 76;
              tabPinTitle = false;
              tabDubleClickToClose = false;
              tabOpenPosition = -1;
            };

            uiCustomization = {
              navbar = {
                position = "top";
                searchBarTop = false;
              };

              display = {
                disableFullscreenNotification = false;
                deleteBrowserBorder = false;
              };

              special = {
                optimizeForTreeStyleTab = true;
                hideForwardBackwardButton = false;
                stgLikeWorkspaces = false;
              };

              multirowTab = {
                newtabInsideEnabled = false;
              };

              bookmarkBar = {
                focusExpand = false;
                position = "top";
              };

              qrCode = {
                disableButton = false;
              };
              disableFloorpStart = true;
            };
          };

          "browser.uiCustomization.state" = builtins.toJSON {
            placements = {
              widget-overflow-fixed-list = [
                "developer-button"
                "edit-controls"
                "email-link-button"
                "characterencoding-button"
                "zoom-controls"
              ];

              unified-extensions-area = [
                "addon_darkreader_org-browser-action"
                "_3c078156-979c-498b-8990-85f7987dd929_-browser-action"
                "sponsorblocker_ajay_app-browser-action"
                "_d07ccf11-c0cd-4938-a265-2a4d6ad01189_-browser-action"
                "firefox-extension_steamdb_info-browser-action"
                "_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action"
                "_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action"
              ];

              nav-bar = [
                "sidebar-button"
                "back-button"
                "forward-button"
                "vertical-spacer"
                "firefox-view-button"
                "stop-reload-button"
                "home-button"
                "customizableui-special-spring12"
                "customizableui-special-spring13"
                "customizableui-special-spring17"
                "customizableui-special-spring18"
                "urlbar-container"
                "_testpilot-containers-browser-action"
                "reset-pbm-toolbar-button"
                "customizableui-special-spring24"
                "customizableui-special-spring23"
                "customizableui-special-spring15"
                "customizableui-special-spring14"
                "downloads-button"
                "ublock0_raymondhill_net-browser-action"
                "adnauseam_rednoise_org-browser-action"
                "unified-extensions-button"
              ];

              toolbar-menubar = [ "menubar-items" ];
              TabsToolbar = [
                "tabbrowser-tabs"
                "new-tab-button"
              ];
              vertical-tabs = [ ];
              PersonalToolbar = [ "personal-bookmarks" ];
              nora-statusbar = [
                "screenshot-button"
                "fullscreen-button"
                "status-text"
              ];
            };
            seen = [
              "reset-pbm-toolbar-button"
              "developer-button"
              "_testpilot-containers-browser-action"
              "ublock0_raymondhill_net-browser-action"
              "adnauseam_rednoise_org-browser-action"
              "screenshot-button"
              "addon_darkreader_org-browser-action"
              "_d07ccf11-c0cd-4938-a265-2a4d6ad01189_-browser-action"
              "_3c078156-979c-498b-8990-85f7987dd929_-browser-action"
              "firefox-extension_steamdb_info-browser-action"
              "_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action"
              "_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action"
              "sponsorblocker_ajay_app-browser-action"
              "profile-manager-button"
              "undo-closed-tab"
            ];
            dirtyAreaCache = [
              "nav-bar"
              "vertical-tabs"
              "PersonalToolbar"
              "unified-extensions-area"
              "TabsToolbar"
              "toolbar-menubar"
              "nora-statusbar"
              "widget-overflow-fixed-list"
            ];
            currentVersion = 23;
            newElementCount = 26;
          };
        };

      # extraConfig = builtins.replaceStrings [ "\npref(" ] [ "\nuser_pref(" ] (
      #   builtins.readFile ../phoenix-desktop.js
      # );

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
        norway = {
          color = "red";
          icon = "circle";
          id = 16;
        };
      };
      extensions.force = true;
      extensions = {
        settings = {
          "uBlock0@raymondhill.net".settings = import ./ublock.nix { inherit lib; };

          "adnauseam@rednoise.org".settings = import ./adnauseam.nix { inherit lib; };

          # "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}".settings = {
          #   styles = lib.importJSON.packages.catppuccin-userstyles;
          # };
        };
      };

      search = import ../search.nix { inherit pkgs; };
    };
  };
}

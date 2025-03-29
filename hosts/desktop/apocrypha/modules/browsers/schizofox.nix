{inputs, ...}: {
  imports = [inputs.schizofox.homeManagerModules.default];

  programs.schizofox = {
    enable = true;

    search = {
      defaultSearchEngine = "DuckDuckGo";
      removeEngines = ["Google" "Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia"];
    };

    extensions = {
      enableDefaultExtensions = true;
      enableExtraExtensions = true;
      darkreader.enable = true;
      extraExtensions = {
        "{531906d3-e22f-4a6c-a102-8057b88a1a63}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/single-file/latest.xpi";
        "DontFuckWithPaste@raim.ist".install_url = "https://addons.mozilla.org/firefox/downloads/latest/don-t-fuck-with-paste/latest.xpi";
        "{3c078156-979c-498b-8990-85f7987dd929}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
        # "FirefoxColor@mozilla.com".install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox-color/latest.xpi";
      };
    };

    settings = {
      "general.autoScroll" = true;
      "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
      "browser.translations.automaticallyPopup" = false;
    };

    theme = {
      colors = {
        background-darker = "1D2021";
        background = "282828";
        foreground = "D5C4A1";
      };

      extraUserChrome = ''
        /**
        * Remove Sidebar Header
        **/
        #sidebar-header {
        display: none;
        }
        /**
        * Dynamic Horizontal Tabs Toolbar (with animations)
        * sidebar.verticalTabs: false (with native horizontal tabs)
        */
        #main-window #TabsToolbar > .toolbar-items {
        overflow: hidden;
        transition: height 0.3s 0.3s !important;
        }
        /* Default state: Set initial height to enable animation */
        #main-window #TabsToolbar > .toolbar-items { height: 3em !important; }
        #main-window[uidensity="touch"] #TabsToolbar > .toolbar-items { height: 3.35em !important; }
        #main-window[uidensity="compact"] #TabsToolbar > .toolbar-items { height: 2.7em !important; }
        /* Hidden state: Hide native tabs strip */
        #main-window[titlepreface*="​"] #TabsToolbar > .toolbar-items { height: 0 !important; }
        /* Hidden state: Fix z-index of active pinned tabs */
        #main-window[titlepreface*="​"] #tabbrowser-tabs { z-index: 0 !important; }
        /* Hidden state: Hide window buttons in tabs-toolbar */
        #main-window[titlepreface*="​"] #TabsToolbar .titlebar-spacer,
        #main-window[titlepreface*="​"] #TabsToolbar .titlebar-buttonbox-container {
        display: none !important;
        }
        /* [Optional] Uncomment block below to show window buttons in nav-bar (maybe, I didn't test it on non-linux-i3wm env) */
        /* #main-window[titlepreface*="​"] #nav-bar > .titlebar-buttonbox-container,
        #main-window[titlepreface*="​"] #nav-bar > .titlebar-buttonbox-container > .titlebar-buttonbox {
        display: flex !important;
        } */
        /* [Optional] Uncomment one of the line below if you need space near window buttons */
        /* #main-window[titlepreface*="​"] #nav-bar > .titlebar-spacer[type="pre-tabs"] { display: flex !important; } */
        /* #main-window[titlepreface*="​"] #nav-bar > .titlebar-spacer[type="post-tabs"] { display: flex !important; } */
      '';
    };

    security.sandbox.enable = true;
  };
}

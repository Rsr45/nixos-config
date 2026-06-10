{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
    # or inputs.zen-browser.homeModules.twilight
    # or inputs.zen-browser.homeModules.twilight-official
  ];

  programs.zen-browser = {
    enable = true;
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
          # (extension "darkreader" "addon@darkreader.org")
          (extension "violentmonkey" "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}")
          (extension "sponsorblock" "sponsorBlocker@ajay.app")
          (extension "tridactyl-vim" "tridactyl.vim@cmcaine.co.uk")
          (extension "multi-account-containers" "@testpilot-containers")
          # (extension "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
          # (extension "view-page-archive" "{d07ccf11-c0cd-4938-a265-2a4d6ad01189}")
          # (extension "steam-database" "firefox-extension@steamdb.info")
          # (extension "augmented-steam" "{1be309c5-3e4f-4b99-927d-bb500eb4fa88}")
          # (extension "libredirect" "7esoorv3@alefvanoon.anonaddy.me")
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
    profiles.default =
      lib.foldl' lib.recursiveUpdate
        {
          isDefault = true;
          settings = (import ./settings.nix { inherit lib pkgs; }) // {
            # "privacy.resistFingerprinting.letterboxing" = true;

            "zen.view.compact.enable-at-startup" = true;

            "browser.uiCustomization.state" = builtins.toJSON {
              placements = {
                widget-overflow-fixed-list = [ ];

                zen-sidebar-top-buttons = [
                  "zen-toggle-compact-mode"
                ];

                zen-sidebar-foot-buttons = [
                  "downloads-button"
                  "zen-workspaces-button"
                  "zen-create-new-button"
                ];

                nav-bar = [
                  "back-button"
                  "forward-button"
                  "stop-reload-button"
                  "customizableui-special-spring1"
                  "vertical-spacer"
                  "urlbar-container"
                  "customizableui-special-spring2"
                  "reset-pbm-toolbar-button"
                  "unified-extensions-button"
                  "ublock0_raymondhill_net-browser-action"
                ];

                toolbar-menubar = [
                  "menubar-items"
                ];

                TabsToolbar = [
                  "tabbrowser-tabs"
                ];

                vertical-tabs = [ ];

                PersonalToolbar = [
                  "personal-bookmarks"
                ];

                unified-extensions-area = [
                  "_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action"
                  "sponsorblocker_ajay_app-browser-action"
                  "_testpilot-containers-browser-action"
                ];
              };

              seen = [
                "reset-pbm-toolbar-button"
                "ublock0_raymondhill_net-browser-action"
                "_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action"
                "sponsorblocker_ajay_app-browser-action"
                "developer-button"
                "screenshot-button"
                "_testpilot-containers-browser-action"
              ];

              dirtyAreaCache = [
                "unified-extensions-area"
                "nav-bar"
              ];

              currentVersion = 24;
              newElementCount = 3;
            };
          };

          extensions = {
            force = true;
            settings = {
              "uBlock0@raymondhill.net".settings = import ./extensions/ublock/default.nix { inherit lib; };
            };
          };

          search = import ./search.nix { inherit pkgs; };

          mods = [
            # "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
            # "4ab93b88-151c-451b-a1b7-a1e0e28fa7f8" # No Sidebar Scrollbar
            # "7190e4e9-bead-4b40-8f57-95d852ddc941" # Tab title fixes
            "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
            "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
            "c01d3e22-1cee-45c1-a25e-53c0f180eea8" # Ghost Tabs
            "cb5efa80-f1e1-43ce-8c0b-fece8462d225" # Container Halo
            "c6813222-6571-4ba6-8faf-58f3343324f6" # Disable webview rounded corners
            "1e9f3101-210b-4ff5-8830-434e4919100d" # Better Letterboxing
          ];
        }
        [
          (import ./containers.nix { inherit lib pkgs; })
        ];
  };
}

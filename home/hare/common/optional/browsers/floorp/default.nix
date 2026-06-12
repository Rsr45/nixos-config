{
  pkgs,
  config,
  lib,
  ...
}: {
  xdg.configFile = {
    "tridactyl/tridactylrc" = {
      source = ./tridactylrc;
    };
  };

  programs.floorp = {
    enable = true;
    nativeMessagingHosts = with pkgs; [
      tridactyl-native
    ];
    policies = {
      ExtensionSettings = with builtins; let
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
          # (extension "darkreader" "addon@darkreader.org")
          (extension "violentmonkey" "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}")
          (extension "sponsorblock" "sponsorBlocker@ajay.app")
          (extension "tridactyl-vim" "tridactyl.vim@cmcaine.co.uk")
          # (extension "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
          # (extension "view-page-archive" "{d07ccf11-c0cd-4938-a265-2a4d6ad01189}")
          # (extension "steam-database" "firefox-extension@steamdb.info")
          # (extension "augmented-steam" "{1be309c5-3e4f-4b99-927d-bb500eb4fa88}")
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
    profiles.default =
      lib.foldl' lib.recursiveUpdate
      {
        isDefault = true;
        userChrome = import ../userCss/Chrome/default.nix {inherit config lib;};
        userContent = import ../userCss/Content/default.nix {inherit config lib;};
        # settings = lib.foldl' lib.recursiveUpdate (import ../settings.nix { inherit lib pkgs; }) (import
        #   ../settings-floorp.nix
        #   { inherit lib pkgs; }
        # ) (import ./settings-uiCustomizations.nix { inherit lib pkgs; });

        settings = lib.foldl' lib.recursiveUpdate {} [
          (import ../settings.nix {inherit lib pkgs;})
          (import ../settings-floorp.nix {inherit lib pkgs;})
          (import ./settings-uiCustomizations.nix {inherit lib pkgs;})
        ];

        # extraConfig = builtins.replaceStrings [ "\npref(" ] [ "\nuser_pref(" ] (
        #   builtins.readFile ../phoenix-desktop.js
        # );

        extensions.force = true;
        extensions = {
          settings = {
            "uBlock0@raymondhill.net".settings = import ../extensions/ublock/default.nix {inherit lib;};

            "adnauseam@rednoise.org".settings = import ../extensions/adnauseam/default.nix {inherit lib;};

            "{3c078156-979c-498b-8990-85f7987dd929}".settings = import ../extensions/sidebery/default.nix {
              inherit config lib;
            };
            # "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}".settings = {
            #   styles = lib.importJSON.packages.catppuccin-userstyles;
            # };
          };
        };

        search = import ../search.nix {inherit pkgs;};
      }
      [
        (import ../containers.nix {inherit lib pkgs;})
      ];
  };
}

{
  config,
  pkgsUnstable,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./default
    # ./phoenix
  ];
  programs.firefox = {
    enable = true;
    # package = pkgsUnstable.firefox;
    # .override {
    #   # See nixpkgs' firefox/wrapper.nix to check which options you can use
    #   nativeMessagingHosts = [
    #     # Gnome shell native connector
    #     # pkgs.gnome-browser-connector
    #     # Tridactyl native connector
    #     pkgs.tridactyl-native
    #   ];
    # };
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    # nativeMessagingHosts = with pkgs; [
    #   tridactyl-native
    # ];

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
          (extension "darkreader" "addon@darkreader.org")
          (extension "violentmonkey" "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}")
          (extension "sponsorblock" "sponsorBlocker@ajay.app")
          # (extension "tridactyl-vim" "tridactyl.vim@cmcaine.co.uk")
          (extension "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
          # (extension "view-page-archive" "{d07ccf11-c0cd-4938-a265-2a4d6ad01189}")
          # (extension "steam-database" "firefox-extension@steamdb.info")
          # (extension "augmented-steam" "{1be309c5-3e4f-4b99-927d-bb500eb4fa88}")
          # (extension "libredirect" "7esoorv3@alefvanoon.anonaddy.me")
          (extension "fmhy-safeguard" "{5d554479-7cc4-487f-bd25-d8fc67a42602}")
        ];
      # To add additional extensions, find it on addons.mozilla.org, find
      # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
      # Then, download the XPI by filling it in to the install_url template, unzip it,
      # run `jq .browser_specific_settings.gecko.id manifest.json` or
      # `jq .applications.gecko.id manifest.json` to get the UUID
      BlockAboutConfig = true;
      DisableFirefoxAccounts = true;
      DefaultDownloadDirectory = "\${home}/Downloads";
    };
  };
}

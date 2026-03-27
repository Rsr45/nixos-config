{ pkgs, lib, ... }:
{
  imports = [
    ./default
    ./phoenix
  ];
  programs.firefox = {
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
          (extension "violentmonkey" "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}")
          (extension "sponsorblock" "sponsorBlocker@ajay.app")
          (extension "sidebery" "{3c078156-979c-498b-8990-85f7987dd929}")
          (extension "darkreader" "addon@darkreader.org")
          (extension "tridactyl-vim" "tridactyl.vim@cmcaine.co.uk")
        ];
      # BlockAboutConfig = true;
      NoDefaultBookmarks = false;
      DefaultDownloadDirectory = "\${home}/Downloads";
    };
  };
}

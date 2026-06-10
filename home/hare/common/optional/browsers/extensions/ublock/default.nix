{lib, ...}: let
  importedLists = import ../blockLists.nix;
in {
  uiAccentCustom = true;
  uiAccentCustom0 = "#CF1D25";
  cloudStorageEnabled = lib.mkForce false;
  advancedUserEnabled = true;
  userFiltersTrusted = true;
  popupPanelSections = 31;
  hiddenSettings = {
    autoCommentFilterTemplate = "{{date}} {{origin}} {{url}}";
    autoUpdateDelayAfterLaunch = 10;
    disableWebAssembly = false;
    filterAuthorMode = true;
    updateAssetBypassBrowserCache = true;
  };
  importedLists = importedLists;
  externalLists = lib.concatStringsSep "\n" importedLists;
  hostnameSwitchesString = import ../hostname.nix;
  dynamicFilteringString = import ../dynamic.nix;
  user-filters = import ../userFilters.nix;
  selectedFilterLists =
    [
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
      "curben-phishing"
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
      "DEU-0"
      "FRA-0"
      "NLD-0"
      "GRC-0"
      "NOR-0"
      "RUS-0"
      "RUS-1"
      "TUR-0"
    ]
    ++ importedLists;
}

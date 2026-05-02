{ lib, ... }:
let
  importedLists = [
    ## Annoyances
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
    # "https://badblock.celenity.dev/abp/unsafe.txt" # inc badblock+
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
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt"
    "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt"
    ## + Misc(non-ad)
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AnnoyancesList"
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AnnoyancesList-2ndDivision.txt"
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AntiAbusePorn.txt"
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AntiSubmissiveEroticaList.txt"
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Special%20security%20lists/AntiFaviconList.txt"
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AntiFakeTransparentImagesList.txt"
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AntiFunctionalityRemovalList.txt"

    ####)olddldldldld
    # "https://raw.githubusercontent.com/mchangrh/yt-neuter/main/yt-neuter.txt"
    # "https://raw.githubusercontent.com/mchangrh/yt-neuter/main/filters/sponsorblock.txt"
    # "https://raw.githubusercontent.com/mchangrh/yt-neuter/main/filters/noview.txt"

    # ## Browse functions
    # "https://codeberg.org/celenity/BadBlock/raw/branch/pages/hardened/block-webrtc.txt"
    # # "https://codeberg.org/celenity/BadBlock/raw/branch/pages/hardened/unbreak-webrtc.txt"
    # "https://codeberg.org/celenity/BadBlock/raw/branch/pages/hardened/block-webgpu.txt"
    # # "https://codeberg.org/celenity/BadBlock/raw/branch/pages/hardened/unbreak-webgpu.txt"
  ];
in
{
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
  hostnameSwitchesString = import ./hostname.nix;
  dynamicFilteringString = import ./dynamic.nix;
  user-filters = import ./userFilters.nix;
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

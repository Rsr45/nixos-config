{...}: let
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
in {
  "privacy.trackingprotection.content.protection.enabled" = true;
  "privacy.trackingprotection.content.protection.test_list_urls" = blocklists;
}

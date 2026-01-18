{ ... }:
{
  programs.qutebrowser = {
    enable = true;
    settings = {
      colors = {
        webpage.darkmode.enabled = true;
      };
      tabs = {
        favicons.show = "never";
        background = false;
      };
      url.searchengines = "{\"DEFAULT\":\"https://html.duckduckgo.com/html/?q={}\"}";
      content.blocking = {
        enabled = true;
        hosts.block_subdomains = true;
        method = "both";
        adblock.lists = [
          "https://easylist.to/easylist/easylist.txt"
          "https://easylist.to/easylist/easyprivacy.txt"
          "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/ultimate.txt"
          "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/tif.txt"
          "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/spam-tlds-ublock.txt"
          "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/dyndns.txt"
          "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/adblock/doh-vpn-proxy-bypass.txt"
          "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt"
          "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
          "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/BrowseWebsitesWithoutLoggingIn.txt"
          "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"
          "https://gitflic.ru/project/magnolia1234/bypass-paywalls-clean-filters/blob/raw?file=bpc-paywall-filter.txt&commit=05db44828fde074ac67ba5c6053c2d26c5158a5b"
          "https://raw.githubusercontent.com/liamengland1/miscfilters/master/antipaywall.txt"
          "https://raw.githubusercontent.com/fmhy/FMHYFilterlist/main/filterlist.txt"
        ];
      };
    };
  };

}

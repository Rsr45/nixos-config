{ ... }:
{
  programs.thunderbird = {
    enable = true;
    # package = pkgs.betterbird;
    profiles.default = {
      isDefault = true;
      # feedAccounts.Feed = { };
      search = {
        default = "searx";
        privateDefault = "startpage";
        force = true;
        engines = {
          startpage = {
            name = "Startpage";
            definedAliases = [ "@startpage" ];
            urls = [
              {
                template = "https://www.startpage.com/sp/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
          searx = {
            name = "SearXNG";
            urls = [
              {
                template = "http://localhost:8080/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "'s" ];
          };
          bing.metaData.hidden = true;
        };
      };
    };
  };
}

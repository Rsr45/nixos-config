{ pkgs, ... }:
{
  default = "searx";
  privateDefault = "ddg";
  force = true;
  order = [
    "searx"
    "ddg"
    "htmlddg"
    "brave"
    "startpage"
    "nixos-wiki"
    "nixos-options"
    "nix-packages"
    "google"
    "bing"
  ];

  engines = {

    searx = {
      name = "SearchXNG";
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
      definedAliases = [ "@s" ];
    };

    brave = {
      name = "Brave";
      urls = [
        {
          template = "https://search.brave.com/search";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      definedAliases = [ "@b" ];
    };
    htmlddg = {
      name = "DuckDuckGo (HTML)";
      urls = [
        {
          template = "https://html.duckduckgo.com/html/";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];
    };
    nix-packages = {
      name = "Nix Packages";
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            {
              name = "type";
              value = "packages";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = [ "@np" ];
    };
    nixos-options = {
      name = "NixOS Options";
      definedAliases = [ "@no" ];
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      urls = [
        {
          template = "https://search.nixos.org/options";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
            {
              name = "channel";
              value = "unstable";
            }
            {
              name = "type";
              value = "packages";
            }
          ];
        }
      ];
    };
    nixos-wiki = {
      name = "NixOS Wiki";
      urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = [ "@nw" ];
    };
  };
}

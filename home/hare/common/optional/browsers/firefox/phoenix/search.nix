{ pkgs, ... }:
{
  programs.firefox.profiles.phoenix.search = {
    default = "startpage";
    privateDefault = "startpage";
    force = true;
    order = [
      "startpage"
      "ddg"
      "ddg-html"
      "nixos-wiki"
      "nixos-options"
      "nix-packages"
      "google"
      "bing"
    ];

    engines = {
      startpage = {
        name = "Startpage";
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
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

      ddg-html = {
        name = "DuckDuckGo (HTML)";
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
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
        definedAliases = [ "'np" ];
      };

      nixos-options = {
        name = "NixOS Options";
        definedAliases = [ "'no" ];
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
        # iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "'nw" ];
      };
    };
  };
}

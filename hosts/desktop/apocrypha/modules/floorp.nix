{pkgs, ...}: {
  programs.floorp = {
    enable = true;

    profiles.rsr = {
      # id = 36;
      isDefault = true;
      search = {
        default = "duckduckgo";
        privateDefault = "duckduckgo";
        force = true;
        order = ["duckduckgo" "nw" "np"];
        engines = {
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
            definedAliases = ["@np"];
          };

          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = ["@nw"];
          };
        };
      };

      settings = {
        "extensions.autoDisableScopes" = 0;
      };

      extensions = {
        force = true;
      };
    };

    policies = {
      BlockAboutConfig = true;
      DisableFirefoxAccounts = true;
      DefaultDownloadDirectory = "\${home}/Downloads";
    };
  };
}

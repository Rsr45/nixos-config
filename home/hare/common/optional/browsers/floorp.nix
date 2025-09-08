{
  pkgs,
  config,
  ...
}:
{
  programs.floorp = {
    enable = true;
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
          (extension "sidebery" "{3c078156-979c-498b-8990-85f7987dd929}")
          # (extension "single-file" "{531906d3-e22f-4a6c-a102-8057b88a1a63}")
          # (extension "vimium-ff" "{d7742d87-e61d-4b78-b8a1-b469842139fa}")
          (extension "darkreader" "addon@darkreader.org")
        ];
      # To add additional extensions, find it on addons.mozilla.org, find
      # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
      # Then, download the XPI by filling it in to the install_url template, unzip it,
      # run `jq .browser_specific_settings.gecko.id manifest.json` or
      # `jq .applications.gecko.id manifest.json` to get the UUID
      BlockAboutConfig = false;
      DisableFirefoxAccounts = true;
      DefaultDownloadDirectory = "\${home}/Downloads";
    };
    profiles.rsr = {
      isDefault = true;
      extensions.force = true;
      settings = {
        "extensions.autoDisableScopes" = 0;
        "general.autoScroll" = true;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "browser.translations.automaticallyPopup" = false;
        "svg.context-properties.content.enabled" = true;
      };
      search = {
        default = "searx"; # i am an idiot. was tryng to use name rather than .{name}
        privateDefault = "searx";
        force = true;
        order = [
          "nw"
          "np"
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
            definedAliases = [ "'s" ];
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
          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = [ "'nw" ];
          };
        };
      };

      bookmarks = {
        force = true;
        settings = [
          {
            name = "Wikipedia";
            tags = [ "wiki" ];
            keyword = "wiki";
            url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
          }
          {
            name = "Documentations";
            toolbar = false;
            bookmarks = [
              {
                name = "NixOS";
                url = "https://wiki.nixos.org/";
                tags = [
                  "nix"
                  "wiki"
                ];
              }
              {
                name = "Home Manager";
                url = "https://nix-community.github.io/home-manager/options.xhtml";
                tags = [
                  "nix"
                  "wiki"
                ];
              }
              {
                name = "Nvf";
                url = "https://notashelf.github.io/nvf/options.html";
                tags = [
                  "nix"
                ];
              }
              {
                name = "Stylix";
                url = "https://stylix.danth.me/";
                tags = [
                  "nix"
                ];
              }
            ];
          }
          {
            name = "Games";
            bookmarks = [
              {
                name = "FMHY";
                url = "https://fmhy.net/";
              }
              {
                name = "Fitgirl";
                url = "https://fitgirl-repacks.site/";
              }
              {
                name = "DODI";
                url = "https://www.1337x.to/user/DODI/";
              }
              {
                name = "GOG";
                url = "https://www.gog-games.to/";
              }
              {
                name = "Xatab";
                url = "https://byxatab.com/";
              }
              {
                name = "Elamigos";
                url = "https://elamigos.site/";
              }
              {
                name = "Itch.io";
                url = "https://itch.io/games/new-and-popular/featured/free";
              }
              {
                name = "Myrient";
                url = "https://myrient.erista.me/";
              }
              {
                name = "Vimm's Lair";
                url = "https://vimm.net/vault";
              }
            ];
          }
        ];
      };
    };
  };
}

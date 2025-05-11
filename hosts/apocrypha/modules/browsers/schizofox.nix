{ inputs, pkgs, ... }:
{
  imports = [
    inputs.schizofox.homeManagerModules.default
    ./sh-userCss.nix
    # ./textfox.nix
  ];

  programs.schizofox = {
    enable = true;
    # package = pkgs.floorp-unwrapped;

    search = {
      defaultSearchEngine = "DuckDuckGo";
      removeEngines = [
        "Google"
        "Bing"
        "Amazon.com"
        "eBay"
        "Twitter"
        "Wikipedia"
        "nixpkgs"
      ];
      addEngines = [
        {
          Name = "Nix Packages";
          Description = "Nix Package Search";
          Alias = "!np";
          Method = "GET";
          URLTemplate = "https://search.nixos.org/packages?type=packages&query={searchTerms}";
        }
        {
          Name = "NixOS Wiki";
          Description = "NixOS Wiki Search";
          Alias = "!nw";
          Method = "GET";
          URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
        }
      ];
    };

    misc = {
      bookmarks = [
        {
          Title = "FMHY";
          URL = "https://fmhy.net/";
        }
        {
          Title = "Fitgirl";
          URL = "https://fitgirl-repacks.site/";
        }
        {
          Title = "DODI";
          URL = "https://www.1337x.to/user/DODI/";
        }
        {
          Title = "GOG";
          URL = "https://www.gog-games.to/";
        }
        {
          Title = "Xatab";
          URL = "https://byxatab.com/";
        }
        {
          Title = "Elamigos";
          URL = "https://elamigos.site/";
        }
        {
          Title = "Itch.io";
          URL = "https://itch.io/games/new-and-popular/featured/free";
        }
        {
          Title = "Myrient";
          URL = "https://myrient.erista.me/";
        }
        {
          Title = "Vimm'S Lair";
          URL = "https://vimm.net/vault";
        }
        {
          Title = "NixOS";
          URL = "https://wiki.nixos.org/";
          Folder = "Documentation";
          # tags = [
          #   "nix"
          #   "wiki"
          # ];
        }
        {
          Title = "Home Manager";
          URL = "https://nix-community.github.io/home-manager/options.xhtml";
          Folder = "Documentation";
          # tags = [
          # tags = [
          #   "nix"
          #   "wiki"
          # ];
        }
        {
          Title = "Nvf";
          URL = "https://notashelf.github.io/nvf/options.html";
          Folder = "Documentation";
          # tags = [
          # tags = [
          #   "nix"
          # ];
        }
        {
          Title = "Stylix";
          URL = "https://stylix.danth.me/";
          Folder = "Documentation";
          # tags = [
          # tags = [
          #   "nix"
          # ];
        }
      ];
      contextMenu.enable = true;
    };

    extensions = {
      enableDefaultExtensions = true;
      enableExtraExtensions = true;
      simplefox.enable = false; # use directly to customize
      darkreader.enable = true;
      extraExtensions = {
        "{531906d3-e22f-4a6c-a102-8057b88a1a63}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/single-file/latest.xpi";
        "{3c078156-979c-498b-8990-85f7987dd929}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
        "FirefoxColor@mozilla.com".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/firefox-color/latest.xpi";
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
      };
    };

    settings = {
      "general.autoScroll" = true;
      "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
      "browser.translations.automaticallyPopup" = false;
    };

    theme = {
      colors = {
        background-darker = "0f0f0f";
        background = "0f0f0f";
        foreground = "cacaca";
        primary = "ac8a8c";
      };
    };

    security.sandbox.enable = false; # borks downloads, specifically file path chooser thingy.
  };
}

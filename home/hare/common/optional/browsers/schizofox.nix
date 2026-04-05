{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    inputs.schizofox.homeManagerModules.default
    # ./vertical-bar.nix
  ];

  programs.schizofox = {
    enable = true;
    search = {
      defaultSearchEngine = "DuckDuckGo (HTML)";
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
        {
          Name = "SearXNG";
          Description = "SearXNG Local Search";
          Alias = "!s";
          Method = "GET";
          URLTemplate = "http://localhost:8080/search?q={searchTerms}";
        }
        {
          Name = "DuckDuckGo (HTML)";
          Description = "DuckDuckGo but HTML";
          Alias = "!s";
          Method = "GET";
          URLTemplate = "https://html.duckduckgo.com/html/?q={searchTerms}";
        }
      ];
    };

    misc = {
      contextMenu.enable = true;
    };

    extensions = {
      enableDefaultExtensions = true;
      enableExtraExtensions = true;
      simplefox = {
        enable = false; # use directly to customize
        showUrlBar = true;
      };
      darkreader.enable = true;
      extraExtensions = {
        "{3c078156-979c-498b-8990-85f7987dd929}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
        # "FirefoxColor@mozilla.com".install_url =
        #   "https://addons.mozilla.org/firefox/downloads/latest/firefox-color/latest.xpi";
        # "{d7742d87-e61d-4b78-b8a1-b469842139fa}".install_url =
        #   "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
        "tridactyl.vim@cmcaine.co.uk".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/tridactyl-vim/latest.xpi";
        "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
        "sponsorBlocker@ajay.app".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
      };
    };

    settings = {
      "general.autoScroll" = true;
      "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
      "browser.translations.automaticallyPopup" = false;
      "widget.use-xdg-desktop-portal.file-picker" = "1";
      "widget.use-xdg-desktop-portal.location" = "1";
      "widget.use-xdg-desktop-portal.mime-handler" = "1";
      "widget.use-xdg-desktop-portal.native-messaging" = "0";
      "widget.use-xdg-desktop-portal.open-uri" = "1";
      "widget.use-xdg-desktop-portal.settings" = "1";
    };

    theme = {
      colors = {
        background = "${config.lib.stylix.colors.base00}";
        background-darker = "${config.lib.stylix.colors.base01}";
        foreground = "${config.lib.stylix.colors.base05}";
        primary = "${config.lib.stylix.colors.base0A}";
        border = "${config.lib.stylix.colors.base0A}";
      };
    };

    security.sandbox.enable = true;
  };
}

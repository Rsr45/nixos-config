{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.firefox = {
    profiles = {
      default =
        lib.foldl' lib.recursiveUpdate
        {
          id = 0;
          isDefault = true;
          # userChrome = import ../userCss/Chrome/default.nix {inherit config lib;};
          # userContent = import ../userCss/Content/default.nix {inherit config lib;};
          # settings = lib.foldl' lib.recursiveUpdate (import ../settings.nix { inherit lib pkgs; }) (import
          #   ../settings-floorp.nix
          #   { inherit lib pkgs; }
          # ) (import ./settings-uiCustomizations.nix { inherit lib pkgs; });

          # settings = lib.foldl' lib.recursiveUpdate {} [
          #   (import ../settings.nix {inherit lib pkgs;})
          # ];

          # extraConfig = builtins.replaceStrings [ "\npref(" ] [ "\nuser_pref(" ] (
          #   builtins.readFile ../phoenix-desktop.js
          # );

          settings = {
            "widget.gtk.libadwaita-colors.enabled" = false;
            "browser.tabs.inTitlebar" = 0;
          };

          extensions.force = true;
          extensions = {
            settings = {
              "uBlock0@raymondhill.net".settings = import ../../extensions/ublock/default.nix {inherit lib;};

              "adnauseam@rednoise.org".settings = import ../../extensions/adnauseam/default.nix {inherit lib;};

              "{3c078156-979c-498b-8990-85f7987dd929}".settings = import ../../extensions/sidebery/default.nix {
                inherit config lib;
              };

              "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}".settings = let
                styles = builtins.fromJSON (builtins.readFile ../../extensions/stylus/styles.json);
                # v6.5.29
                # github-dark_user_css = pkgs.fetchurl {
                #   url = "https://raw.githubusercontent.com/StylishThemes/GitHub-Dark/cee30ae0f344e449f9114f4dc35c74942852b460/github-dark.user.css";
                #   hash = "sha256-L2kSdeD73nc3BznKtH2+5/nuai8KX8EDVseJCoTn9VI=";
                # };
              in {
                dbInChromeStorage = true;
                "style-1" =
                  builtins.elemAt styles 0;
              };
            };
          };

          search = import ../../search.nix {inherit pkgs;};
        }
        [
          (import ../../containers.nix {inherit lib pkgs;})
        ];
    };
  };
}

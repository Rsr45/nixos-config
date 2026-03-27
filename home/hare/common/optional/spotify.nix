{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify =
    let
      # spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];

      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        ncsVisualizer
      ];

      enabledSnippets = with spicePkgs.snippets; [
        rotatingCoverart
        pointer
      ];

      # theme = {
      #   # Name of the theme
      #   name = "Throwback";
      #   # The source of the theme
      #   src = pkgs.fetchFromGitHub {
      #     owner = "bluedrift";
      #     repo = "Spicetify-Throwback/Throwback";
      #     rev = "4eade188f2e16f937596f0d5f4532bec707521ee";
      #     hash = "sha256-kgTwzPSHCe1BPeVHHVwg1hHXgwPcJf2d07PXVijmNcc=";
      #   };
      #
      #   # Additional theme options all set to defaults
      #   # the docs of the theme should say which of these
      #   # if any you have to change
      #   injectCss = true;
      #   injectThemeJs = true;
      #   replaceColors = true;
      #   sidebarConfig = true;
      #   homeConfig = true;
      #   overwriteAssets = false;
      #   additonalCss = "@import url('${config.xdg.configHome}/spicetify/colors.css');";
      # };
      theme = spicePkgs.themes.text;
      # colorScheme = "Throwback";
    };
}

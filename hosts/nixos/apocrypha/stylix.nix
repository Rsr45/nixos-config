{ pkgs, inputs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  hostSpec = {
    cornerRadius = 0;
    cornerRadiusRatio = 0;
  };

  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";

    homeManagerIntegration.followSystem = false;
    homeManagerIntegration.autoImport = false;

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    cursor = {
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Gruvbox)";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      sansSerif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      monospace = {
        package = pkgs.iosevka;
        name = "Iosevka";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        desktop = 12;
        popups = 12;
        applications = 12;
        terminal = 12;
      };
    };

    targets = {
      plymouth.enable = true;
      console.enable = true;
      fontconfig.enable = true;
      font-packages.enable = true;
      qt = {
        enable = true;
        platform = "qtct";
      };
      gtk.enable = true;
    };
  };
}
